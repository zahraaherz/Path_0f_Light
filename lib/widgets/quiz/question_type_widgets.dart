import 'package:flutter/material.dart';
import '../../config/theme/app_theme.dart';

/// True/False Question Widget
class TrueFalseQuestion extends StatelessWidget {
  final String question;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final String? correctAnswer;
  final bool isArabic;

  const TrueFalseQuestion({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    this.showResult = false,
    this.correctAnswer,
    this.isArabic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildOption(
          'A',
          isArabic ? 'صح' : 'True',
          Icons.check_circle_outline,
        ),
        const SizedBox(height: 12),
        _buildOption(
          'B',
          isArabic ? 'خطأ' : 'False',
          Icons.cancel_outlined,
        ),
      ],
    );
  }

  Widget _buildOption(String key, String label, IconData icon) {
    final isSelected = selectedAnswer == key;
    Color? backgroundColor;
    Color? borderColor;
    IconData? resultIcon;
    Color? iconColor;

    if (showResult && correctAnswer != null) {
      if (key == correctAnswer) {
        backgroundColor = AppTheme.success.withOpacity(0.1);
        borderColor = AppTheme.success;
        resultIcon = Icons.check_circle;
        iconColor = AppTheme.success;
      } else if (isSelected && key != correctAnswer) {
        backgroundColor = AppTheme.error.withOpacity(0.1);
        borderColor = AppTheme.error;
        resultIcon = Icons.cancel;
        iconColor = AppTheme.error;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryTeal.withOpacity(0.1);
      borderColor = AppTheme.primaryTeal;
    }

    return InkWell(
      onTap: showResult ? null : () => onAnswerSelected(key),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            color: borderColor ?? Colors.grey.shade300,
            width: borderColor != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (borderColor ?? AppTheme.primaryTeal).withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconColor?.withOpacity(0.1) ??
                    (isSelected ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.grey.shade100),
                border: Border.all(
                  color: borderColor ?? (isSelected ? AppTheme.primaryTeal : Colors.grey.shade300),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                resultIcon ?? icon,
                color: iconColor ?? (isSelected ? AppTheme.primaryTeal : AppTheme.textSecondary),
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: iconColor ?? (isSelected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fill in the Blank Question Widget
class FillInBlankQuestion extends StatefulWidget {
  final String question;
  final String blankText;
  final List<String> options;
  final String? selectedAnswer;
  final Function(String) onAnswerSelected;
  final bool showResult;
  final String? correctAnswer;
  final bool isArabic;

  const FillInBlankQuestion({
    super.key,
    required this.question,
    required this.blankText,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
    this.showResult = false,
    this.correctAnswer,
    this.isArabic = false,
  });

  @override
  State<FillInBlankQuestion> createState() => _FillInBlankQuestionState();
}

class _FillInBlankQuestionState extends State<FillInBlankQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question with blank
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.islamicGreen.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.islamicGreen.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 18,
                height: 1.6,
                color: AppTheme.textPrimary,
              ),
              children: _buildQuestionWithBlank(),
            ),
            textDirection: widget.isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: widget.isArabic ? TextAlign.right : TextAlign.left,
          ),
        ),

        const SizedBox(height: 24),

        // Options
        Text(
          widget.isArabic ? 'اختر الإجابة:' : 'Select the answer:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        ...widget.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final key = String.fromCharCode(65 + index); // A, B, C, D
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildOption(key, option),
          );
        }).toList(),
      ],
    );
  }

  List<InlineSpan> _buildQuestionWithBlank() {
    final parts = widget.question.split(widget.blankText);
    final spans = <InlineSpan>[];

    for (int i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        spans.add(TextSpan(text: parts[i]));
      }

      if (i < parts.length - 1) {
        spans.add(
          WidgetSpan(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: widget.selectedAnswer != null
                    ? AppTheme.primaryTeal.withOpacity(0.2)
                    : Colors.white,
                border: Border.all(
                  color: AppTheme.primaryTeal,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.selectedAnswer ?? '______',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryTeal,
                ),
              ),
            ),
          ),
        );
      }
    }

    return spans;
  }

  Widget _buildOption(String key, String text) {
    final isSelected = widget.selectedAnswer == text;
    Color? backgroundColor;
    Color? borderColor;
    IconData? icon;
    Color? iconColor;

    if (widget.showResult && widget.correctAnswer != null) {
      if (text == widget.correctAnswer) {
        backgroundColor = AppTheme.success.withOpacity(0.1);
        borderColor = AppTheme.success;
        icon = Icons.check_circle;
        iconColor = AppTheme.success;
      } else if (isSelected && text != widget.correctAnswer) {
        backgroundColor = AppTheme.error.withOpacity(0.1);
        borderColor = AppTheme.error;
        icon = Icons.cancel;
        iconColor = AppTheme.error;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryTeal.withOpacity(0.1);
      borderColor = AppTheme.primaryTeal;
    }

    return InkWell(
      onTap: widget.showResult ? null : () => widget.onAnswerSelected(text),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            color: borderColor ?? Colors.grey.shade300,
            width: borderColor != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor?.withOpacity(0.1) ??
                    (isSelected ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.grey.shade100),
                border: Border.all(
                  color: borderColor ?? (isSelected ? AppTheme.primaryTeal : Colors.grey.shade300),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: icon != null
                    ? Icon(icon, color: iconColor, size: 20)
                    : Text(
                        key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: iconColor ?? (isSelected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Matching Question Widget
class MatchingQuestion extends StatefulWidget {
  final Map<String, String> leftItems;
  final Map<String, String> rightItems;
  final Map<String, String> selectedMatches;
  final Function(String left, String right) onMatchSelected;
  final bool showResult;
  final Map<String, String>? correctMatches;
  final bool isArabic;

  const MatchingQuestion({
    super.key,
    required this.leftItems,
    required this.rightItems,
    required this.selectedMatches,
    required this.onMatchSelected,
    this.showResult = false,
    this.correctMatches,
    this.isArabic = false,
  });

  @override
  State<MatchingQuestion> createState() => _MatchingQuestionState();
}

class _MatchingQuestionState extends State<MatchingQuestion> {
  String? selectedLeftItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.isArabic ? 'طابق العناصر:' : 'Match the items:',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 20),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: Column(
                children: widget.leftItems.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildLeftItem(entry.key, entry.value),
                  );
                }).toList(),
              ),
            ),

            // Connector lines
            SizedBox(
              width: 60,
              child: Column(
                children: List.generate(
                  widget.leftItems.length,
                  (index) => Container(
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 2,
                        color: AppTheme.primaryTeal.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Right column
            Expanded(
              child: Column(
                children: widget.rightItems.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildRightItem(entry.key, entry.value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeftItem(String key, String text) {
    final isSelected = selectedLeftItem == key;
    final isMatched = widget.selectedMatches.containsKey(key);

    return InkWell(
      onTap: widget.showResult ? null : () {
        setState(() {
          selectedLeftItem = isSelected ? null : key;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMatched
              ? AppTheme.success.withOpacity(0.1)
              : (isSelected ? AppTheme.primaryTeal.withOpacity(0.1) : Colors.white),
          border: Border.all(
            color: isMatched
                ? AppTheme.success
                : (isSelected ? AppTheme.primaryTeal : Colors.grey.shade300),
            width: isMatched || isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isMatched
                    ? AppTheme.success
                    : (isSelected ? AppTheme.primaryTeal : Colors.grey.shade200),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightItem(String key, String text) {
    final isMatchedTo = widget.selectedMatches.values.contains(key);

    return InkWell(
      onTap: widget.showResult || selectedLeftItem == null
          ? null
          : () {
              widget.onMatchSelected(selectedLeftItem!, key);
              setState(() {
                selectedLeftItem = null;
              });
            },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMatchedTo ? AppTheme.success.withOpacity(0.1) : Colors.white,
          border: Border.all(
            color: isMatchedTo ? AppTheme.success : Colors.grey.shade300,
            width: isMatchedTo ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isMatchedTo ? AppTheme.success : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
