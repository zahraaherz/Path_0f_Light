import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../widgets/energy_display.dart';

class EnhancedQuizScreen extends ConsumerStatefulWidget {
  final EnhancedQuestion question;
  final int currentIndex;
  final int totalQuestions;
  final String languageCode; // 'ar' or 'en'

  const EnhancedQuizScreen({
    super.key,
    required this.question,
    required this.currentIndex,
    required this.totalQuestions,
    this.languageCode = 'en',
  });

  @override
  ConsumerState<EnhancedQuizScreen> createState() => _EnhancedQuizScreenState();
}

class _EnhancedQuizScreenState extends ConsumerState<EnhancedQuizScreen> {
  String? selectedAnswer;
  bool showingResult = false;
  bool isCorrect = false;
  Timer? _resultTimer;

  @override
  void dispose() {
    _resultTimer?.cancel();
    super.dispose();
  }

  bool get isArabic => widget.languageCode == 'ar';

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final questionText = isArabic ? question.questionAr : question.questionEn;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: Text(
          '${isArabic ? 'السؤال' : 'Question'} ${widget.currentIndex + 1}/${widget.totalQuestions}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppTheme.primaryTeal,
        elevation: 0,
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            height: 4,
            child: LinearProgressIndicator(
              value: (widget.currentIndex + (showingResult ? 1 : 0)) / widget.totalQuestions,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Category & Points Card
                  _buildCategoryCard(question),

                  const SizedBox(height: 20),

                  // Question Card
                  _buildQuestionCard(questionText, question),

                  const SizedBox(height: 24),

                  // Answer Options
                  ...question.options.entries.map((option) {
                    return _buildAnswerOption(option, question);
                  }).toList(),

                  const SizedBox(height: 24),

                  // Submit Button or Result Display
                  if (!showingResult)
                    _buildSubmitButton()
                  else
                    _buildResultDisplay(question),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(EnhancedQuestion question) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryTeal.withOpacity(0.1),
            AppTheme.islamicGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryTeal.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.category_outlined,
                  color: AppTheme.goldAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.category.replaceAll('_', ' ').toUpperCase(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    question.difficulty.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getDifficultyColor(question.difficulty),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.goldAccent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.goldAccent.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.stars, size: 16, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '${question.points}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String questionText, EnhancedQuestion question) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.islamicGreen.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getQuestionTypeIcon(question.questionType),
                  color: AppTheme.info,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _getQuestionTypeLabel(question.questionType),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.info,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            questionText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.6,
                  color: AppTheme.textPrimary,
                ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerOption(MapEntry<String, Map<String, String>> option, EnhancedQuestion question) {
    final isSelected = selectedAnswer == option.key;
    final optionText = isArabic
        ? option.value['text_ar'] ?? ''
        : option.value['text_en'] ?? '';

    Color? backgroundColor;
    Color? borderColor;
    IconData? iconData;
    Color? iconColor;

    if (showingResult) {
      if (option.key == question.correctAnswer) {
        backgroundColor = AppTheme.success.withOpacity(0.1);
        borderColor = AppTheme.success;
        iconData = Icons.check_circle;
        iconColor = AppTheme.success;
      } else if (isSelected && !isCorrect) {
        backgroundColor = AppTheme.error.withOpacity(0.1);
        borderColor = AppTheme.error;
        iconData = Icons.cancel;
        iconColor = AppTheme.error;
      }
    } else if (isSelected) {
      backgroundColor = AppTheme.primaryTeal.withOpacity(0.1);
      borderColor = AppTheme.primaryTeal;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: showingResult ? null : () {
          setState(() => selectedAnswer = option.key);
        },
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
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: (borderColor ?? AppTheme.primaryTeal).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
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
                  child: iconData != null
                      ? Icon(iconData, color: iconColor, size: 24)
                      : Text(
                          option.key,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: iconColor ?? (isSelected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  optionText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: selectedAnswer == null ? null : _submitAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: Text(
          isArabic ? 'إرسال الإجابة' : 'Submit Answer',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay(EnhancedQuestion question) {
    final explanation = isArabic ? question.explanationAr : question.explanationEn;
    final bookTitle = isArabic
        ? question.source.bookTitleAr ?? 'Unknown Book'
        : question.source.bookTitleEn ?? 'Unknown Book';

    return Column(
      children: [
        // Result Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isCorrect
                  ? [AppTheme.success.withOpacity(0.1), AppTheme.success.withOpacity(0.05)]
                  : [AppTheme.error.withOpacity(0.1), AppTheme.error.withOpacity(0.05)],
            ),
            border: Border.all(
              color: isCorrect ? AppTheme.success : AppTheme.error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? AppTheme.success.withOpacity(0.2)
                          : AppTheme.error.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? AppTheme.success : AppTheme.error,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect
                              ? (isArabic ? 'إجابة صحيحة!' : 'Correct!')
                              : (isArabic ? 'إجابة خاطئة' : 'Incorrect'),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? AppTheme.success : AppTheme.error,
                          ),
                        ),
                        Text(
                          '+ ${question.points} ${isArabic ? 'نقطة' : 'points'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 1),
              const SizedBox(height: 16),

              // Explanation
              Text(
                isArabic ? 'الشرح:' : 'Explanation:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                explanation,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: AppTheme.textSecondary,
                ),
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.grey, thickness: 1),
              const SizedBox(height: 16),

              // Book Source
              _buildBookSource(question, bookTitle),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Next Question Button
        SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _nextQuestion,
            icon: Icon(isArabic ? Icons.arrow_back : Icons.arrow_forward),
            label: Text(
              isArabic ? 'السؤال التالي' : 'Next Question',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryTeal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookSource(EnhancedQuestion question, String bookTitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.islamicGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.islamicGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu_book,
                color: AppTheme.islamicGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isArabic ? 'المصدر:' : 'Source:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppTheme.islamicGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            bookTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
          const SizedBox(height: 8),
          Text(
            '${isArabic ? 'صفحة' : 'Page'} ${question.source.pageNumber}',
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Text(
              question.source.exactQuoteAr,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: AppTheme.textPrimary,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _saveBook(question.source.bookId),
                  icon: const Icon(Icons.bookmark_add, size: 18),
                  label: Text(
                    isArabic ? 'حفظ الكتاب' : 'Save Book',
                    style: const TextStyle(fontSize: 14),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryTeal,
                    side: const BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showBookRedirectDialog(question.source.bookId, bookTitle),
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: Text(
                    isArabic ? 'اذهب للكتاب' : 'Go to Book',
                    style: const TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitAnswer() {
    if (selectedAnswer == null) return;

    setState(() {
      isCorrect = selectedAnswer == widget.question.correctAnswer;
      showingResult = true;
    });

    // Auto advance after 5 seconds
    _resultTimer = Timer(const Duration(seconds: 5), _nextQuestion);
  }

  void _nextQuestion() {
    _resultTimer?.cancel();
    // Navigate to next question or results
    // This would typically call a callback or navigate
    Navigator.of(context).pop();
  }

  void _saveBook(String bookId) {
    // Save book to user's collection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic ? 'تم حفظ الكتاب في مجموعتك' : 'Book saved to your collection',
        ),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showBookRedirectDialog(String bookId, String bookTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber, color: AppTheme.warning, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isArabic ? 'تحذير' : 'Warning',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        content: Text(
          isArabic
              ? 'الانتقال إلى الكتاب سيؤدي إلى إنهاء اللعبة الحالية. هل أنت متأكد؟'
              : 'Going to the book will end the current game. Are you sure?',
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: const TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to book screen
              _redirectToBook(bookId, bookTitle);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryTeal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(isArabic ? 'متابعة' : 'Continue'),
          ),
        ],
      ),
    );
  }

  void _redirectToBook(String bookId, String bookTitle) {
    // Navigate to book reading screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic ? 'جاري فتح: $bookTitle' : 'Opening: $bookTitle',
        ),
        backgroundColor: AppTheme.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    // TODO: Navigate to book screen with bookId
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'basic':
        return AppTheme.success;
      case 'intermediate':
        return AppTheme.info;
      case 'advanced':
        return AppTheme.warning;
      case 'expert':
        return AppTheme.error;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getQuestionTypeIcon(QuestionType type) {
    switch (type) {
      case QuestionType.multipleChoice:
        return Icons.list_alt;
      case QuestionType.trueFalse:
        return Icons.check_box;
      case QuestionType.fillInBlank:
        return Icons.text_fields;
      case QuestionType.matching:
        return Icons.shuffle;
    }
  }

  String _getQuestionTypeLabel(QuestionType type) {
    final labels = {
      QuestionType.multipleChoice: isArabic ? 'اختيار من متعدد' : 'Multiple Choice',
      QuestionType.trueFalse: isArabic ? 'صح أو خطأ' : 'True/False',
      QuestionType.fillInBlank: isArabic ? 'املأ الفراغ' : 'Fill in the Blank',
      QuestionType.matching: isArabic ? 'مطابقة' : 'Matching',
    };
    return labels[type] ?? '';
  }
}
