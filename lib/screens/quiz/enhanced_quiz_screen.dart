import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../config/theme/app_theme.dart';
import '../../models/quiz/quiz_models.dart';
import '../../widgets/energy_display.dart';
import '../../utils/responsive.dart';

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
    final r = context.responsive;
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: r.spaceSmall),
            child: const EnergyDisplay(showLabel: false),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          Container(
            height: r.valueWhen(mobile: 3, tablet: 4, desktop: 5),
            child: LinearProgressIndicator(
              value: (widget.currentIndex + (showingResult ? 1 : 0)) / widget.totalQuestions,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryTeal),
            ),
          ),

          Expanded(
            child: r.constrainWidth(  // Max width on large screens
              child: SingleChildScrollView(
                padding: EdgeInsets.all(r.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Category & Points Card
                    _buildCategoryCard(question, r),

                    SizedBox(height: r.spaceLarge),

                    // Question Card
                    _buildQuestionCard(questionText, question, r),

                    SizedBox(height: r.spaceLarge),

                    // Answer Options
                    ...question.options.entries.map((option) {
                      return _buildAnswerOption(option, question, r);
                    }).toList(),

                    SizedBox(height: r.spaceLarge),

                    // Submit Button or Result Display
                    if (!showingResult)
                      _buildSubmitButton(r)
                    else
                      _buildResultDisplay(question, r),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(EnhancedQuestion question, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryTeal.withOpacity(0.1),
            AppTheme.islamicGreen.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(r.radiusLarge),
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
                padding: EdgeInsets.all(r.spaceSmall),
                decoration: BoxDecoration(
                  color: AppTheme.goldAccent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(r.radiusSmall),
                ),
                child: Icon(
                  Icons.category_outlined,
                  color: AppTheme.goldAccent,
                  size: r.iconSmall,
                ),
              ),
              SizedBox(width: r.spaceSmall),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.category.replaceAll('_', ' ').toUpperCase(),
                    style: TextStyle(
                      fontSize: r.fontMedium,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    question.difficulty.toUpperCase(),
                    style: TextStyle(
                      fontSize: r.fontSmall,
                      color: _getDifficultyColor(question.difficulty),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: r.paddingMedium,
              vertical: r.spaceSmall,
            ),
            decoration: BoxDecoration(
              color: AppTheme.goldAccent,
              borderRadius: BorderRadius.circular(r.radiusLarge),
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
                Icon(Icons.stars, size: r.iconSmall * 0.8, color: Colors.white),
                SizedBox(width: r.spaceSmall * 0.5),
                Text(
                  '${question.points}',
                  style: TextStyle(
                    fontSize: r.fontLarge,
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

  Widget _buildQuestionCard(String questionText, EnhancedQuestion question, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r.radiusMedium),
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
                padding: EdgeInsets.all(r.spaceSmall),
                decoration: BoxDecoration(
                  color: AppTheme.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(r.radiusSmall),
                ),
                child: Icon(
                  _getQuestionTypeIcon(question.questionType),
                  color: AppTheme.info,
                  size: r.iconSmall,
                ),
              ),
              SizedBox(width: r.spaceSmall),
              Expanded(
                child: Text(
                  _getQuestionTypeLabel(question.questionType),
                  style: TextStyle(
                    fontSize: r.fontSmall,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.info,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: r.spaceMedium),
          Text(
            questionText,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: r.fontXLarge,
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

  Widget _buildAnswerOption(MapEntry<String, Map<String, String>> option, EnhancedQuestion question, Responsive r) {
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
      padding: EdgeInsets.only(bottom: r.spaceSmall),
      child: InkWell(
        onTap: showingResult ? null : () {
          setState(() => selectedAnswer = option.key);
        },
        borderRadius: BorderRadius.circular(r.radiusMedium),
        child: Container(
          padding: EdgeInsets.all(r.paddingMedium),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            border: Border.all(
              color: borderColor ?? Colors.grey.shade300,
              width: borderColor != null ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(r.radiusMedium),
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
                width: r.valueWhen(mobile: 44, desktop: 56),
                height: r.valueWhen(mobile: 44, desktop: 56),
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
                      ? Icon(iconData, color: iconColor, size: r.iconMedium)
                      : Text(
                          option.key,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: r.fontLarge,
                            color: iconColor ?? (isSelected ? AppTheme.primaryTeal : AppTheme.textPrimary),
                          ),
                        ),
                ),
              ),
              SizedBox(width: r.spaceMedium),
              Expanded(
                child: Text(
                  optionText,
                  style: TextStyle(
                    fontSize: r.fontLarge,
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

  Widget _buildSubmitButton(Responsive r) {
    return SizedBox(
      height: r.buttonHeight,
      child: ElevatedButton(
        onPressed: selectedAnswer == null ? null : _submitAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(r.radiusMedium),
          ),
          elevation: 4,
        ),
        child: Text(
          isArabic ? 'إرسال الإجابة' : 'Submit Answer',
          style: TextStyle(
            fontSize: r.fontLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildResultDisplay(EnhancedQuestion question, Responsive r) {
    final explanation = isArabic ? question.explanationAr : question.explanationEn;
    final bookTitle = isArabic
        ? question.source.bookTitleAr ?? 'Unknown Book'
        : question.source.bookTitleEn ?? 'Unknown Book';

    return Column(
      children: [
        // Result Card
        Container(
          padding: EdgeInsets.all(r.paddingLarge),
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
            borderRadius: BorderRadius.circular(r.radiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(r.spaceSmall),
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? AppTheme.success.withOpacity(0.2)
                          : AppTheme.error.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? AppTheme.success : AppTheme.error,
                      size: r.iconMedium,
                    ),
                  ),
                  SizedBox(width: r.spaceMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect
                              ? (isArabic ? 'إجابة صحيحة!' : 'Correct!')
                              : (isArabic ? 'إجابة خاطئة' : 'Incorrect'),
                          style: TextStyle(
                            fontSize: r.fontTitle,
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? AppTheme.success : AppTheme.error,
                          ),
                        ),
                        Text(
                          '+ ${question.points} ${isArabic ? 'نقطة' : 'points'}',
                          style: TextStyle(
                            fontSize: r.fontLarge,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: r.spaceLarge),
              const Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: r.spaceMedium),

              // Explanation
              Text(
                isArabic ? 'الشرح:' : 'Explanation:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontLarge,
                  color: AppTheme.textPrimary,
                ),
              ),
              SizedBox(height: r.spaceSmall),
              Text(
                explanation,
                style: TextStyle(
                  fontSize: r.fontMedium,
                  height: 1.6,
                  color: AppTheme.textSecondary,
                ),
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
              ),

              SizedBox(height: r.spaceLarge),
              const Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: r.spaceMedium),

              // Book Source
              _buildBookSource(question, bookTitle, r),
            ],
          ),
        ),

        SizedBox(height: r.spaceMedium),

        // Next Question Button
        SizedBox(
          height: r.buttonHeight,
          child: ElevatedButton.icon(
            onPressed: _nextQuestion,
            icon: Icon(isArabic ? Icons.arrow_back : Icons.arrow_forward),
            label: Text(
              isArabic ? 'السؤال التالي' : 'Next Question',
              style: TextStyle(
                fontSize: r.fontLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryTeal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(r.radiusMedium),
              ),
              elevation: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookSource(EnhancedQuestion question, String bookTitle, Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.paddingMedium),
      decoration: BoxDecoration(
        color: AppTheme.islamicGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(r.radiusMedium),
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
              Icon(
                Icons.menu_book,
                color: AppTheme.islamicGreen,
                size: r.iconSmall,
              ),
              SizedBox(width: r.spaceSmall),
              Text(
                isArabic ? 'المصدر:' : 'Source:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontMedium,
                  color: AppTheme.islamicGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            bookTitle,
            style: TextStyle(
              fontSize: r.fontLarge,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
          SizedBox(height: r.spaceSmall),
          Text(
            '${isArabic ? 'صفحة' : 'Page'} ${question.source.pageNumber}',
            style: TextStyle(
              fontSize: r.fontMedium,
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: r.spaceSmall),
          Container(
            padding: EdgeInsets.all(r.spaceSmall),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(r.radiusSmall),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Text(
              question.source.exactQuoteAr,
              style: TextStyle(
                fontSize: r.fontMedium,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: AppTheme.textPrimary,
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: r.spaceMedium),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _saveBook(question.source.bookId),
                  icon: Icon(Icons.bookmark_add, size: r.iconSmall),
                  label: Text(
                    isArabic ? 'حفظ الكتاب' : 'Save Book',
                    style: TextStyle(fontSize: r.fontMedium),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryTeal,
                    side: const BorderSide(color: AppTheme.primaryTeal, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.radiusSmall),
                    ),
                    padding: EdgeInsets.symmetric(vertical: r.spaceSmall),
                  ),
                ),
              ),
              SizedBox(width: r.spaceSmall),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showBookRedirectDialog(question.source.bookId, bookTitle),
                  icon: Icon(Icons.arrow_forward, size: r.iconSmall),
                  label: Text(
                    isArabic ? 'اذهب للكتاب' : 'Go to Book',
                    style: TextStyle(fontSize: r.fontMedium),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(r.radiusSmall),
                    ),
                    padding: EdgeInsets.symmetric(vertical: r.spaceSmall),
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
    final r = context.responsive;

    // Save book to user's collection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic ? 'تم حفظ الكتاب في مجموعتك' : 'Book saved to your collection',
          style: TextStyle(fontSize: r.fontMedium),
        ),
        backgroundColor: AppTheme.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r.radiusSmall)),
      ),
    );
  }

  void _showBookRedirectDialog(String bookId, String bookTitle) {
    final r = context.responsive;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r.radiusLarge)),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: AppTheme.warning, size: r.iconMedium),
            SizedBox(width: r.spaceSmall),
            Expanded(
              child: Text(
                isArabic ? 'تحذير' : 'Warning',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: r.fontXLarge,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          isArabic
              ? 'الانتقال إلى الكتاب سيؤدي إلى إنهاء اللعبة الحالية. هل أنت متأكد؟'
              : 'Going to the book will end the current game. Are you sure?',
          style: TextStyle(fontSize: r.fontLarge, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: r.fontMedium,
              ),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r.radiusSmall)),
            ),
            child: Text(
              isArabic ? 'متابعة' : 'Continue',
              style: TextStyle(fontSize: r.fontMedium),
            ),
          ),
        ],
      ),
    );
  }

  void _redirectToBook(String bookId, String bookTitle) {
    final r = context.responsive;

    // Navigate to book reading screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic ? 'جاري فتح: $bookTitle' : 'Opening: $bookTitle',
          style: TextStyle(fontSize: r.fontMedium),
        ),
        backgroundColor: AppTheme.info,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(r.radiusSmall)),
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
