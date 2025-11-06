import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String titleAr;
  final String titleEn;
  final String authorAr;
  final String authorEn;
  final int totalSections;
  final int totalParagraphs;
  final String language;
  final String? pdfUrl;
  final String version;
  final String? verifiedBy;
  final String contentStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Book({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.authorAr,
    required this.authorEn,
    required this.totalSections,
    required this.totalParagraphs,
    required this.language,
    this.pdfUrl,
    required this.version,
    this.verifiedBy,
    required this.contentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      titleAr: data['title_ar'] ?? '',
      titleEn: data['title_en'] ?? '',
      authorAr: data['author_ar'] ?? '',
      authorEn: data['author_en'] ?? '',
      totalSections: data['total_sections'] ?? 0,
      totalParagraphs: data['total_paragraphs'] ?? 0,
      language: data['language'] ?? 'arabic',
      pdfUrl: data['pdf_url'],
      version: data['version'] ?? '1.0',
      verifiedBy: data['verified_by'],
      contentStatus: data['content_status'] ?? 'pending',
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title_ar': titleAr,
      'title_en': titleEn,
      'author_ar': authorAr,
      'author_en': authorEn,
      'total_sections': totalSections,
      'total_paragraphs': totalParagraphs,
      'language': language,
      'pdf_url': pdfUrl,
      'version': version,
      'verified_by': verifiedBy,
      'content_status': contentStatus,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}
