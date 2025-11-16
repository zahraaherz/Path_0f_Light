import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection_providers.dart';
import '../../providers/auth_providers.dart';

/// Dialog for adding a new item to the collection
class AddToCollectionDialog extends ConsumerStatefulWidget {
  const AddToCollectionDialog({Key? key}) : super(key: key);

  @override
  ConsumerState<AddToCollectionDialog> createState() =>
      _AddToCollectionDialogState();
}

class _AddToCollectionDialogState
    extends ConsumerState<AddToCollectionDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _arabicTitleController = TextEditingController();
  final _arabicTextController = TextEditingController();
  final _translationController = TextEditingController();
  final _transliterationController = TextEditingController();
  final _notesController = TextEditingController();
  final _sourceController = TextEditingController();
  final _tagsController = TextEditingController();

  CollectionItemType _selectedType = CollectionItemType.dua;
  CollectionCategory _selectedCategory = CollectionCategory.daily;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _arabicTitleController.dispose();
    _arabicTextController.dispose();
    _translationController.dispose();
    _transliterationController.dispose();
    _notesController.dispose();
    _sourceController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add to Collection',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type selection
                      Text(
                        'Type',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CollectionItemType>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select type',
                        ),
                        items: CollectionItemType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(_getTypeName(type)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedType = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Category selection
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CollectionCategory>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select category',
                        ),
                        items: CollectionCategory.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(_getCategoryName(category)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title (English)',
                          border: OutlineInputBorder(),
                          hintText: 'Enter title in English',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Arabic Title
                      TextFormField(
                        controller: _arabicTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Title (Arabic)',
                          border: OutlineInputBorder(),
                          hintText: 'Enter title in Arabic',
                        ),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontFamily: 'Amiri'),
                      ),
                      const SizedBox(height: 16),

                      // Arabic Text
                      TextFormField(
                        controller: _arabicTextController,
                        decoration: const InputDecoration(
                          labelText: 'Arabic Text *',
                          border: OutlineInputBorder(),
                          hintText: 'Enter text in Arabic',
                        ),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Arabic text is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Translation
                      TextFormField(
                        controller: _translationController,
                        decoration: const InputDecoration(
                          labelText: 'Translation',
                          border: OutlineInputBorder(),
                          hintText: 'Enter English translation',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Transliteration
                      TextFormField(
                        controller: _transliterationController,
                        decoration: const InputDecoration(
                          labelText: 'Transliteration',
                          border: OutlineInputBorder(),
                          hintText: 'Enter transliteration',
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Source
                      TextFormField(
                        controller: _sourceController,
                        decoration: const InputDecoration(
                          labelText: 'Source',
                          border: OutlineInputBorder(),
                          hintText: 'e.g., Sahifa Sajjadiya, Du\'a 23',
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Notes
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Personal Notes',
                          border: OutlineInputBorder(),
                          hintText: 'Add your personal notes',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      TextFormField(
                        controller: _tagsController,
                        decoration: const InputDecoration(
                          labelText: 'Tags',
                          border: OutlineInputBorder(),
                          hintText: 'Separate tags with commas',
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            // Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveItem,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Add to Collection'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Save the collection item
  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        throw Exception('User not logged in');
      }

      // Parse tags
      final tags = _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList();

      // Create collection item
      final item = CollectionItem(
        id: '', // Will be set by Firestore
        userId: userId,
        type: _selectedType,
        title: _titleController.text,
        arabicTitle: _arabicTitleController.text.isEmpty
            ? null
            : _arabicTitleController.text,
        arabicText: _arabicTextController.text,
        translation: _translationController.text.isEmpty
            ? null
            : _translationController.text,
        transliteration: _transliterationController.text.isEmpty
            ? null
            : _transliterationController.text,
        category: _selectedCategory,
        source: _sourceController.text.isEmpty
            ? null
            : _sourceController.text,
        notes: _notesController.text.isEmpty
            ? null
            : _notesController.text,
        tags: tags,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to repository
      await ref
          .read(collectionRepositoryProvider)
          .addCollectionItem(item);

      // Invalidate providers to refresh
      ref.invalidate(userCollectionItemsProvider);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added to collection successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getTypeName(CollectionItemType type) {
    switch (type) {
      case CollectionItemType.dua:
        return 'Du\'a';
      case CollectionItemType.surah:
        return 'Surah';
      case CollectionItemType.ayah:
        return 'Ayah';
      case CollectionItemType.ziyarat:
        return 'Ziyarat';
      case CollectionItemType.hadith:
        return 'Hadith';
      case CollectionItemType.passage:
        return 'Passage';
      case CollectionItemType.dhikr:
        return 'Dhikr';
      case CollectionItemType.custom:
        return 'Custom';
    }
  }

  String _getCategoryName(CollectionCategory category) {
    switch (category) {
      case CollectionCategory.morning:
        return 'Morning';
      case CollectionCategory.evening:
        return 'Evening';
      case CollectionCategory.friday:
        return 'Friday';
      case CollectionCategory.ramadhan:
        return 'Ramadhan';
      case CollectionCategory.muharram:
        return 'Muharram';
      case CollectionCategory.safar:
        return 'Safar';
      case CollectionCategory.rajab:
        return 'Rajab';
      case CollectionCategory.shaban:
        return 'Sha\'ban';
      case CollectionCategory.daily:
        return 'Daily';
      case CollectionCategory.weekly:
        return 'Weekly';
      case CollectionCategory.monthly:
        return 'Monthly';
      case CollectionCategory.special:
        return 'Special Occasions';
      case CollectionCategory.protection:
        return 'Protection';
      case CollectionCategory.forgiveness:
        return 'Forgiveness';
      case CollectionCategory.gratitude:
        return 'Gratitude';
      case CollectionCategory.healing:
        return 'Healing';
      case CollectionCategory.guidance:
        return 'Guidance';
      case CollectionCategory.custom:
        return 'Custom';
    }
  }
}
