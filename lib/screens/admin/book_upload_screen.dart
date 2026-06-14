import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import '../../config/theme/app_theme.dart';
import '../../utils/responsive.dart';

/// Admin screen for uploading books with images
class BookUploadScreen extends ConsumerStatefulWidget {
  const BookUploadScreen({super.key});

  @override
  ConsumerState<BookUploadScreen> createState() => _BookUploadScreenState();
}

class _BookUploadScreenState extends ConsumerState<BookUploadScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  final _titleArController = TextEditingController();
  final _titleEnController = TextEditingController();
  final _authorArController = TextEditingController();
  final _authorEnController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _volumeNumberController = TextEditingController();
  final _seriesController = TextEditingController();

  File? _selectedPdfFile;
  File? _selectedCoverImage;
  String _language = 'ar';
  List<String> _topics = [];
  final _topicController = TextEditingController();

  bool _isUploading = false;
  double _uploadProgress = 0.0;
  String _uploadStatus = '';

  @override
  void dispose() {
    _titleArController.dispose();
    _titleEnController.dispose();
    _authorArController.dispose();
    _authorEnController.dispose();
    _descriptionController.dispose();
    _volumeNumberController.dispose();
    _seriesController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  Future<void> _pickPdfFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedPdfFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      _showError('Error picking PDF: $e');
    }
  }

  Future<void> _pickCoverImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedCoverImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      _showError('Error picking image: $e');
    }
  }

  void _addTopic() {
    if (_topicController.text.trim().isNotEmpty) {
      setState(() {
        _topics.add(_topicController.text.trim());
        _topicController.clear();
      });
    }
  }

  void _removeTopic(int index) {
    setState(() {
      _topics.removeAt(index);
    });
  }

  Future<void> _uploadBook() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPdfFile == null) {
      _showError('Please select a PDF file');
      return;
    }

    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
      _uploadStatus = 'Preparing upload...';
    });

    try {
      // Generate book ID
      final bookId = _generateBookId();

      // Step 1: Upload cover image if selected
      String? coverImageUrl;
      if (_selectedCoverImage != null) {
        setState(() => _uploadStatus = 'Uploading cover image...');
        coverImageUrl = await _uploadCoverImage(bookId);
        setState(() => _uploadProgress = 0.3);
      }

      // Step 2: Upload PDF to Firebase Storage
      setState(() => _uploadStatus = 'Uploading PDF...');
      final pdfFileName = '${bookId}.pdf';
      final pdfStoragePath = 'islamic_books/$pdfFileName';

      final pdfRef = FirebaseStorage.instance.ref(pdfStoragePath);
      final uploadTask = pdfRef.putFile(_selectedPdfFile!);

      uploadTask.snapshotEvents.listen((snapshot) {
        final progress = 0.3 + (snapshot.bytesTransferred / snapshot.totalBytes) * 0.4;
        setState(() {
          _uploadProgress = progress;
          _uploadStatus = 'Uploading PDF: ${(progress * 100).toStringAsFixed(0)}%';
        });
      });

      await uploadTask;
      final pdfUrl = await pdfRef.getDownloadURL();
      setState(() => _uploadProgress = 0.7);

      // Step 3: Create book metadata in Firestore
      setState(() => _uploadStatus = 'Creating book record...');
      await _createBookRecord(
        bookId: bookId,
        pdfUrl: pdfUrl,
        pdfFileName: pdfFileName,
        pdfStoragePath: pdfStoragePath,
        coverImageUrl: coverImageUrl,
      );
      setState(() => _uploadProgress = 1.0);

      // Success!
      setState(() => _uploadStatus = 'Upload complete!');

      if (!mounted) return;
      _showSuccess('Book uploaded successfully! Processing will start automatically.');
      _resetForm();
    } catch (e) {
      _showError('Upload failed: $e');
    } finally {
      setState(() => _isUploading = false);
    }
  }

  String _generateBookId() {
    // Generate ID from title and timestamp
    final titleSlug = _titleEnController.text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${titleSlug}_$timestamp';
  }

  Future<String> _uploadCoverImage(String bookId) async {
    final coverRef = FirebaseStorage.instance
        .ref('book_covers/$bookId.jpg');

    await coverRef.putFile(_selectedCoverImage!);
    return await coverRef.getDownloadURL();
  }

  Future<void> _createBookRecord({
    required String bookId,
    required String pdfUrl,
    required String pdfFileName,
    required String pdfStoragePath,
    String? coverImageUrl,
  }) async {
    final bookData = {
      'id': bookId,
      'title_ar': _titleArController.text.trim(),
      'title_en': _titleEnController.text.trim(),
      'author_ar': _authorArController.text.trim(),
      'author_en': _authorEnController.text.trim(),
      'description': _descriptionController.text.trim(),
      'language': _language,
      'topics': _topics,
      'volume_number': int.tryParse(_volumeNumberController.text) ?? 1,
      'series': _seriesController.text.trim(),

      // Storage info
      'pdf_url': pdfUrl,
      'original_filename': pdfFileName,
      'storage_path': pdfStoragePath,
      'cover_image_url': coverImageUrl,

      // Processing status
      'processing_status': 'pending',
      'content_status': 'draft',

      // Metadata
      'total_sections': 0,
      'total_paragraphs': 0,
      'total_pages': 0,
      'version': '1.0',

      // Timestamps
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('books')
        .doc(bookId)
        .set(bookData);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleArController.clear();
    _titleEnController.clear();
    _authorArController.clear();
    _authorEnController.clear();
    _descriptionController.clear();
    _volumeNumberController.clear();
    _seriesController.clear();
    _topicController.clear();
    setState(() {
      _selectedPdfFile = null;
      _selectedCoverImage = null;
      _topics.clear();
      _language = 'ar';
      _uploadProgress = 0.0;
      _uploadStatus = '';
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.error,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.success,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Book'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(r.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // PDF File Selection
              _buildFilePickerCard(
                title: 'PDF File *',
                file: _selectedPdfFile,
                onPick: _pickPdfFile,
                icon: Icons.picture_as_pdf,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),

              // Cover Image Selection
              _buildFilePickerCard(
                title: 'Cover Image (Optional)',
                file: _selectedCoverImage,
                onPick: _pickCoverImage,
                icon: Icons.image,
                r: r,
                isImage: true,
              ),
              SizedBox(height: r.spaceLarge),

              // Title Fields
              _buildTextField(
                controller: _titleArController,
                label: 'Title (Arabic) *',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                textDirection: TextDirection.rtl,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),
              _buildTextField(
                controller: _titleEnController,
                label: 'Title (English) *',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),

              // Author Fields
              _buildTextField(
                controller: _authorArController,
                label: 'Author (Arabic) *',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                textDirection: TextDirection.rtl,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),
              _buildTextField(
                controller: _authorEnController,
                label: 'Author (English) *',
                validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),

              // Description
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 4,
                r: r,
              ),
              SizedBox(height: r.spaceMedium),

              // Language
              DropdownButtonFormField<String>(
                value: _language,
                decoration: InputDecoration(
                  labelText: 'Language',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(r.radiusSmall),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'fa', child: Text('Farsi')),
                  DropdownMenuItem(value: 'ur', child: Text('Urdu')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _language = value);
                },
              ),
              SizedBox(height: r.spaceMedium),

              // Volume and Series
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _volumeNumberController,
                      label: 'Volume Number',
                      keyboardType: TextInputType.number,
                      r: r,
                    ),
                  ),
                  SizedBox(width: r.spaceMedium),
                  Expanded(
                    flex: 2,
                    child: _buildTextField(
                      controller: _seriesController,
                      label: 'Series Name',
                      r: r,
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.spaceMedium),

              // Topics
              _buildTopicsSection(r),
              SizedBox(height: r.spaceLarge),

              // Upload Progress
              if (_isUploading) ...[
                LinearProgressIndicator(value: _uploadProgress),
                SizedBox(height: r.spaceSmall),
                Text(
                  _uploadStatus,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: r.spaceLarge),
              ],

              // Upload Button
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadBook,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(r.paddingLarge),
                  backgroundColor: AppTheme.primaryTeal,
                ),
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Upload Book',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePickerCard({
    required String title,
    required File? file,
    required VoidCallback onPick,
    required IconData icon,
    required Responsive r,
    bool isImage = false,
  }) {
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: file != null ? AppTheme.success : AppTheme.primaryTeal.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryTeal),
              SizedBox(width: r.spaceSmall),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: r.spaceSmall),
          if (file != null) ...[
            if (isImage && _selectedCoverImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(r.radiusSmall),
                child: Image.file(
                  _selectedCoverImage!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Text(
                file.path.split('/').last,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            SizedBox(height: r.spaceSmall),
          ],
          ElevatedButton.icon(
            onPressed: onPick,
            icon: Icon(file != null ? Icons.change_circle : Icons.upload_file),
            label: Text(file != null ? 'Change' : 'Select File'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Responsive r,
    String? Function(String?)? validator,
    TextDirection? textDirection,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(r.radiusSmall),
        ),
      ),
      validator: validator,
      textDirection: textDirection,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
    );
  }

  Widget _buildTopicsSection(Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(r.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Topics',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: r.spaceSmall),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    hintText: 'Add topic',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(r.radiusSmall),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: r.paddingMedium,
                      vertical: r.paddingSmall,
                    ),
                  ),
                  onSubmitted: (_) => _addTopic(),
                ),
              ),
              SizedBox(width: r.spaceSmall),
              IconButton(
                onPressed: _addTopic,
                icon: const Icon(Icons.add_circle),
                color: AppTheme.primaryTeal,
              ),
            ],
          ),
          if (_topics.isNotEmpty) ...[
            SizedBox(height: r.spaceSmall),
            Wrap(
              spacing: r.spaceSmall,
              runSpacing: r.spaceSmall,
              children: _topics.asMap().entries.map((entry) {
                return Chip(
                  label: Text(entry.value),
                  onDeleted: () => _removeTopic(entry.key),
                  deleteIcon: const Icon(Icons.close, size: 18),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
