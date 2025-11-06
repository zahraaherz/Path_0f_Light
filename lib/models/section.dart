import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  final String id;
  final String bookId;
  final String bookTitleAr;
  final String bookTitleEn;
  final int sectionNumber;
  final String titleAr;
  final String titleEn;
  final int paragraphCount;
  final String pageRange;
  final String difficultyLevel;
  final List<String> topics;

  Section({
    required this.id,
    required this.bookId,
    required this.bookTitleAr,
    required this.bookTitleEn,
    required this.sectionNumber,
    required this.titleAr,
    required this.titleEn,
    required this.paragraphCount,
    required this.pageRange,
    required this.difficultyLevel,
    required this.topics,
  });

  factory Section.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Section(
      id: doc.id,
      bookId: data['book_id'] ?? '',
      bookTitleAr: data['book_title_ar'] ?? '',
      bookTitleEn: data['book_title_en'] ?? '',
      sectionNumber: data['section_number'] ?? 0,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      paragraphCount: data['paragraph_count'] ?? 0,
      pageRange: data['page_range'] ?? '',
      difficultyLevel: data['difficulty_level'] ?? 'basic',
      topics: List<String>.from(data['topics'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'book_id': bookId,
      'book_title_ar': bookTitleAr,
      'book_title_en': bookTitleEn,
      'section_number': sectionNumber,
      'title_ar': titleAr,
      'title_en': titleEn,
      'paragraph_count': paragraphCount,
      'page_range': pageRange,
      'difficulty_level': difficultyLevel,
      'topics': topics,
    };
  }
}
