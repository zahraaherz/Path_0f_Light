import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../models/collection/reminder.dart';
import '../../models/collection/collection_item.dart';
import '../../providers/collection_providers.dart';
import '../../providers/auth_providers.dart';
import '../../config/theme/app_theme.dart';

/// Dialog for setting a reminder for a collection item
class SetReminderDialog extends ConsumerStatefulWidget {
  final CollectionItem item;
  final Reminder? existingReminder; // If editing an existing reminder

  const SetReminderDialog({
    Key? key,
    required this.item,
    this.existingReminder,
  }) : super(key: key);

  @override
  ConsumerState<SetReminderDialog> createState() => _SetReminderDialogState();
}

class _SetReminderDialogState extends ConsumerState<SetReminderDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _messageController;

  late ReminderTriggerType _triggerType;
  late ReminderFrequency _frequency;
  late bool _soundEnabled;
  late bool _vibrationEnabled;

  TimeOfDay? _selectedTime;
  PrayerTimeOption? _selectedPrayerTime;
  List<DayOfWeek> _selectedDays = [];
  int _minutesBeforePrayer = 0;
  int _minutesAfterPrayer = 0;

  @override
  void initState() {
    super.initState();

    // Initialize with existing reminder data or defaults
    final reminder = widget.existingReminder;
    _titleController = TextEditingController(
      text: reminder?.title ?? 'Reminder for ${widget.item.title}',
    );
    _messageController = TextEditingController(
      text: reminder?.message ?? '',
    );

    _triggerType = reminder?.triggerType ?? ReminderTriggerType.time;
    _frequency = reminder?.frequency ?? ReminderFrequency.daily;
    _soundEnabled = reminder?.soundEnabled ?? true;
    _vibrationEnabled = reminder?.vibrationEnabled ?? true;

    if (reminder != null) {
      _selectedPrayerTime = reminder.prayerTime;
      _selectedDays = List.from(reminder.daysOfWeek);
      _minutesBeforePrayer = reminder.minutesBeforePrayer;
      _minutesAfterPrayer = reminder.minutesAfterPrayer;

      if (reminder.triggerTime != null) {
        final parts = reminder.triggerTime!.split(':');
        _selectedTime = TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = widget.existingReminder != null;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    isEditing ? l10n.editReminder : l10n.setReminder,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Reminder title
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: l10n.reminderTitle,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Reminder message (optional)
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: '${l10n.reminderMessage} (${l10n.optional})',
                      border: const OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 24),

                  // Trigger Type
                  Text(
                    l10n.triggerType,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<ReminderTriggerType>(
                    segments: [
                      ButtonSegment(
                        value: ReminderTriggerType.time,
                        label: Text(l10n.specificTime),
                        icon: const Icon(Icons.access_time),
                      ),
                      ButtonSegment(
                        value: ReminderTriggerType.prayerTime,
                        label: Text(l10n.prayerTime),
                        icon: const Icon(Icons.mosque),
                      ),
                    ],
                    selected: {_triggerType},
                    onSelectionChanged: (Set<ReminderTriggerType> newSelection) {
                      setState(() {
                        _triggerType = newSelection.first;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Trigger-specific fields
                  if (_triggerType == ReminderTriggerType.time)
                    _buildTimeSelector(l10n),

                  if (_triggerType == ReminderTriggerType.prayerTime)
                    _buildPrayerTimeSelector(l10n),

                  const SizedBox(height: 24),

                  // Frequency
                  Text(
                    l10n.frequency,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ReminderFrequency>(
                    value: _frequency,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: ReminderFrequency.once,
                        child: Text(l10n.once),
                      ),
                      DropdownMenuItem(
                        value: ReminderFrequency.daily,
                        child: Text(l10n.daily),
                      ),
                      DropdownMenuItem(
                        value: ReminderFrequency.weekly,
                        child: Text(l10n.weekly),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _frequency = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),

                  // Notification settings
                  Text(
                    l10n.notifications,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: Text(l10n.enableSound),
                    value: _soundEnabled,
                    onChanged: (value) {
                      setState(() {
                        _soundEnabled = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(l10n.enableVibration),
                    value: _vibrationEnabled,
                    onChanged: (value) {
                      setState(() {
                        _vibrationEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.cancel),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _saveReminder,
                        child: Text(l10n.save),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectTime,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime ?? TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _selectedTime = time;
                  });
                }
              },
              icon: const Icon(Icons.access_time),
              label: Text(
                _selectedTime != null
                    ? _selectedTime!.format(context)
                    : l10n.selectTime,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTimeSelector(AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.prayerTime,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<PrayerTimeOption>(
              value: _selectedPrayerTime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text(l10n.selectPrayerTime),
              items: PrayerTimeOption.values.map((prayer) {
                return DropdownMenuItem(
                  value: prayer,
                  child: Text(prayer.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPrayerTime = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: _minutesBeforePrayer.toString(),
                    decoration: InputDecoration(
                      labelText: l10n.minutesBefore,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _minutesBeforePrayer = int.tryParse(value) ?? 0;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    initialValue: _minutesAfterPrayer.toString(),
                    decoration: InputDecoration(
                      labelText: l10n.minutesAfter,
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _minutesAfterPrayer = int.tryParse(value) ?? 0;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveReminder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate trigger-specific requirements
    if (_triggerType == ReminderTriggerType.time && _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.selectTime)),
      );
      return;
    }

    if (_triggerType == ReminderTriggerType.prayerTime && _selectedPrayerTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.selectPrayerTime)),
      );
      return;
    }

    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    final isEditing = widget.existingReminder != null;

    final reminder = Reminder(
      id: isEditing ? widget.existingReminder!.id : '',
      userId: user.id,
      collectionItemId: widget.item.id,
      title: _titleController.text.trim(),
      message: _messageController.text.trim().isEmpty
          ? null
          : _messageController.text.trim(),
      triggerType: _triggerType,
      frequency: _frequency,
      triggerTime: _triggerType == ReminderTriggerType.time
          ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
          : null,
      prayerTime: _triggerType == ReminderTriggerType.prayerTime
          ? _selectedPrayerTime
          : null,
      minutesBeforePrayer: _minutesBeforePrayer,
      minutesAfterPrayer: _minutesAfterPrayer,
      daysOfWeek: _selectedDays,
      soundEnabled: _soundEnabled,
      vibrationEnabled: _vibrationEnabled,
      createdAt: isEditing ? widget.existingReminder!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      if (isEditing) {
        await ref.read(updateReminderProvider(reminder).future);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.reminderUpdated)),
          );
        }
      } else {
        await ref.read(addReminderProvider(reminder).future);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.reminderCreated)),
          );
        }
      }

      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context)!.error}: $e')),
        );
      }
    }
  }
}
