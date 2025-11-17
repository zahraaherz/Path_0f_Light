import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/library/reading_models.dart';
import '../../providers/reading_providers.dart';

class ReadingSettingsSheet extends ConsumerWidget {
  const ReadingSettingsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(readingPreferencesProvider);
    final notifier = ref.read(readingPreferencesProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reading Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Font Size
                _SettingSection(
                  title: 'Font Size',
                  child: Wrap(
                    spacing: 8,
                    children: FontSize.values.map((size) {
                      final isSelected = preferences.fontSize == size;
                      return ChoiceChip(
                        label: Text(_getFontSizeLabel(size)),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) notifier.setFontSize(size);
                        },
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Font Family
                _SettingSection(
                  title: 'Font Family',
                  child: Column(
                    children: FontFamily.values.map((family) {
                      final isSelected = preferences.fontFamily == family;
                      return RadioListTile<FontFamily>(
                        title: Text(
                          _getFontFamilyLabel(family),
                          style: TextStyle(
                            fontFamily: _getFontFamilyName(family),
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          'نموذج النص العربي',
                          style: TextStyle(
                            fontFamily: _getFontFamilyName(family),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        value: family,
                        groupValue: preferences.fontFamily,
                        onChanged: (value) {
                          if (value != null) notifier.setFontFamily(value);
                        },
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Background Color
                _SettingSection(
                  title: 'Background',
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: BackgroundColor.values.map((bg) {
                      final isSelected = preferences.backgroundColor == bg;
                      return GestureDetector(
                        onTap: () => notifier.setBackgroundColor(bg),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: _getBackgroundColorValue(bg),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300]!,
                              width: isSelected ? 3 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: 24,
                                ),
                              const SizedBox(height: 4),
                              Text(
                                _getBackgroundLabel(bg),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getTextColorForBg(bg),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Line Spacing
                _SettingSection(
                  title: 'Line Spacing',
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Compact'),
                          Text(
                            preferences.lineSpacing.toStringAsFixed(1),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('Relaxed'),
                        ],
                      ),
                      Slider(
                        value: preferences.lineSpacing,
                        min: 1.0,
                        max: 2.0,
                        divisions: 10,
                        onChanged: (value) => notifier.setLineSpacing(value),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Text Alignment
                _SettingSection(
                  title: 'Text Alignment',
                  child: Wrap(
                    spacing: 8,
                    children: TextAlign.values.map((align) {
                      final isSelected = preferences.textAlign == align;
                      return ChoiceChip(
                        label: Text(_getTextAlignLabel(align)),
                        selected: isSelected,
                        avatar: Icon(
                          _getTextAlignIcon(align),
                          size: 18,
                        ),
                        onSelected: (selected) {
                          if (selected) notifier.setTextAlign(align);
                        },
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 24),

                // Auto Scroll
                _SettingSection(
                  title: 'Auto Scroll',
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Enable Auto Scroll'),
                        subtitle: const Text('Automatically scroll while reading'),
                        value: preferences.autoScroll,
                        onChanged: (value) => notifier.setAutoScroll(value),
                        contentPadding: EdgeInsets.zero,
                      ),
                      if (preferences.autoScroll) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Slow'),
                            Text(
                              '${preferences.scrollSpeed.toStringAsFixed(0)}x',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text('Fast'),
                          ],
                        ),
                        Slider(
                          value: preferences.scrollSpeed,
                          min: 10.0,
                          max: 100.0,
                          divisions: 9,
                          onChanged: (value) => notifier.setScrollSpeed(value),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Night Mode
                _SettingSection(
                  title: 'Display',
                  child: SwitchListTile(
                    title: const Text('Night Mode'),
                    subtitle: const Text('Reduce brightness for night reading'),
                    value: preferences.enableNightMode,
                    onChanged: (value) => notifier.toggleNightMode(),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getFontSizeLabel(FontSize size) {
    switch (size) {
      case FontSize.small:
        return 'Small';
      case FontSize.medium:
        return 'Medium';
      case FontSize.large:
        return 'Large';
      case FontSize.xlarge:
        return 'XLarge';
    }
  }

  String _getFontFamilyLabel(FontFamily family) {
    switch (family) {
      case FontFamily.amiri:
        return 'Amiri';
      case FontFamily.scheherazade:
        return 'Scheherazade';
      case FontFamily.notoNaskh:
        return 'Noto Naskh Arabic';
      case FontFamily.traditional:
        return 'Traditional Arabic';
    }
  }

  String _getFontFamilyName(FontFamily family) {
    switch (family) {
      case FontFamily.amiri:
        return 'Amiri';
      case FontFamily.scheherazade:
        return 'Scheherazade';
      case FontFamily.notoNaskh:
        return 'Noto Naskh Arabic';
      case FontFamily.traditional:
        return 'Traditional Arabic';
    }
  }

  String _getBackgroundLabel(BackgroundColor bg) {
    switch (bg) {
      case BackgroundColor.white:
        return 'White';
      case BackgroundColor.sepia:
        return 'Sepia';
      case BackgroundColor.dark:
        return 'Dark';
      case BackgroundColor.black:
        return 'Black';
    }
  }

  Color _getBackgroundColorValue(BackgroundColor bg) {
    switch (bg) {
      case BackgroundColor.white:
        return Colors.white;
      case BackgroundColor.sepia:
        return const Color(0xFFF4ECD8);
      case BackgroundColor.dark:
        return const Color(0xFF2C2C2E);
      case BackgroundColor.black:
        return Colors.black;
    }
  }

  Color _getTextColorForBg(BackgroundColor bg) {
    switch (bg) {
      case BackgroundColor.white:
      case BackgroundColor.sepia:
        return Colors.black;
      case BackgroundColor.dark:
      case BackgroundColor.black:
        return Colors.white;
    }
  }

  String _getTextAlignLabel(TextAlign align) {
    switch (align) {
      case TextAlign.justified:
        return 'Justified';
      case TextAlign.right:
        return 'Right';
      case TextAlign.left:
        return 'Left';
      case TextAlign.center:
        return 'Center';
    }
  }

  IconData _getTextAlignIcon(TextAlign align) {
    switch (align) {
      case TextAlign.justified:
        return Icons.format_align_justify;
      case TextAlign.right:
        return Icons.format_align_right;
      case TextAlign.left:
        return Icons.format_align_left;
      case TextAlign.center:
        return Icons.format_align_center;
    }
  }
}

class _SettingSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
