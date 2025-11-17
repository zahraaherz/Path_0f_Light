import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection_providers.dart';
import '../../providers/auth_providers.dart';
import '../../providers/guest_access_providers.dart';

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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.addToCollection,
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
                        l10n.type,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CollectionItemType>(
                        value: _selectedType,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: l10n.selectType,
                        ),
                        items: CollectionItemType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(_getTypeName(context, type)),
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
                        l10n.category,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<CollectionCategory>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: l10n.selectCategory,
                        ),
                        items: CollectionCategory.values.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(_getCategoryName(context, category)),
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
                        decoration: InputDecoration(
                          labelText: l10n.titleEnglish,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterTitleEnglish,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.titleRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Arabic Title
                      TextFormField(
                        controller: _arabicTitleController,
                        decoration: InputDecoration(
                          labelText: l10n.titleArabic,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterTitleArabic,
                        ),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(fontFamily: 'Amiri'),
                      ),
                      const SizedBox(height: 16),

                      // Arabic Text
                      TextFormField(
                        controller: _arabicTextController,
                        decoration: InputDecoration(
                          labelText: l10n.arabicTextRequired,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterArabicText,
                        ),
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          fontFamily: 'Amiri',
                          fontSize: 18,
                        ),
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.arabicTextIsRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Translation
                      TextFormField(
                        controller: _translationController,
                        decoration: InputDecoration(
                          labelText: l10n.translation,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterTranslation,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Transliteration
                      TextFormField(
                        controller: _transliterationController,
                        decoration: InputDecoration(
                          labelText: l10n.transliteration,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterTransliteration,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),

                      // Source
                      TextFormField(
                        controller: _sourceController,
                        decoration: InputDecoration(
                          labelText: l10n.source,
                          border: const OutlineInputBorder(),
                          hintText: l10n.enterSource,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Notes
                      TextFormField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: l10n.personalNotes,
                          border: const OutlineInputBorder(),
                          hintText: l10n.addPersonalNotes,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      TextFormField(
                        controller: _tagsController,
                        decoration: InputDecoration(
                          labelText: l10n.tags,
                          border: const OutlineInputBorder(),
                          hintText: l10n.separateTagsWithCommas,
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
                    child: Text(l10n.cancel),
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
                        : Text(l10n.addToCollection),
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
      // Auto-sign in as guest if user is not logged in
      var userId = ref.read(currentUserIdProvider);
      if (userId == null) {
        final guestService = ref.read(guestAccessServiceProvider);
        final userCredential = await guestService.signInAsGuest();
        userId = userCredential.user?.uid;

        if (userId == null) {
          throw Exception('Failed to sign in as guest');
        }
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
        final l10n = AppLocalizations.of(context)!;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.itemAddedSuccessfully),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.error}: $e'),
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

  String _getTypeName(BuildContext context, CollectionItemType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case CollectionItemType.dua:
        return l10n.dua;
      case CollectionItemType.surah:
        return l10n.surah;
      case CollectionItemType.ayah:
        return l10n.ayah;
      case CollectionItemType.ziyarat:
        return l10n.ziyarat;
      case CollectionItemType.hadith:
        return l10n.hadith;
      case CollectionItemType.passage:
        return l10n.passage;
      case CollectionItemType.dhikr:
        return l10n.dhikr;
      case CollectionItemType.custom:
        return l10n.custom;
    }
  }

  String _getCategoryName(BuildContext context, CollectionCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case CollectionCategory.morning:
        return l10n.morning;
      case CollectionCategory.evening:
        return l10n.evening;
      case CollectionCategory.friday:
        return l10n.friday;
      case CollectionCategory.ramadhan:
        return l10n.ramadhan;
      case CollectionCategory.muharram:
        return l10n.muharram;
      case CollectionCategory.safar:
        return l10n.safar;
      case CollectionCategory.rajab:
        return l10n.rajab;
      case CollectionCategory.shaban:
        return l10n.shaban;
      case CollectionCategory.daily:
        return l10n.daily;
      case CollectionCategory.weekly:
        return l10n.weekly;
      case CollectionCategory.monthly:
        return l10n.monthly;
      case CollectionCategory.special:
        return l10n.specialOccasions;
      case CollectionCategory.protection:
        return l10n.protection;
      case CollectionCategory.forgiveness:
        return l10n.forgiveness;
      case CollectionCategory.gratitude:
        return l10n.gratitude;
      case CollectionCategory.healing:
        return l10n.healing;
      case CollectionCategory.guidance:
        return l10n.guidance;
      case CollectionCategory.custom:
        return l10n.custom;
    }
  }
}
