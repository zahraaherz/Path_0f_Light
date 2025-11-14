import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'comment_models.freezed.dart';
part 'comment_models.g.dart';

/// Book comment model
@freezed
class BookComment with _$BookComment {
  const factory BookComment({
    required String id,
    required String bookId,
    required String paragraphId,
    required String userId,
    required String username,
    String? userPhoto,
    required String text,
    @Default(false) bool isPrivate,
    @Default(0) int likes,
    @Default([]) List<String> likedBy,
    @Default(0) int replies,
    String? parentCommentId, // For reply threading
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @Default(false) bool isEdited,
    @Default(false) bool isReported,
    @Default(false) bool isDeleted,
  }) = _BookComment;

  factory BookComment.fromJson(Map<String, dynamic> json) =>
      _$BookCommentFromJson(json);
}

/// Comment reply (same as BookComment but with parentCommentId)
typedef CommentReply = BookComment;

/// Paragraph report model
@freezed
class ParagraphReport with _$ParagraphReport {
  const factory ParagraphReport({
    required String id,
    required String bookId,
    required String paragraphId,
    required String userId,
    required String issueType,
    required String description,
    @Default(ReportStatus.pending) ReportStatus status,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? resolvedAt,
    String? resolvedBy,
    String? resolution,
  }) = _ParagraphReport;

  factory ParagraphReport.fromJson(Map<String, dynamic> json) =>
      _$ParagraphReportFromJson(json);
}

/// Report status enum
enum ReportStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('reviewed')
  reviewed,
  @JsonValue('resolved')
  resolved,
  @JsonValue('dismissed')
  dismissed,
}

/// Issue type enum for reports
enum IssueType {
  @JsonValue('typo')
  typo,
  @JsonValue('wrong_content')
  wrongContent,
  @JsonValue('formatting')
  formatting,
  @JsonValue('translation')
  translation,
  @JsonValue('other')
  other,
}

/// Comment action result
@freezed
class CommentActionResult with _$CommentActionResult {
  const factory CommentActionResult({
    required bool success,
    required String message,
    BookComment? comment,
    String? error,
  }) = _CommentActionResult;

  factory CommentActionResult.fromJson(Map<String, dynamic> json) =>
      _$CommentActionResultFromJson(json);
}

/// Comments list response
@freezed
class CommentsList with _$CommentsList {
  const factory CommentsList({
    @Default([]) List<BookComment> comments,
    @Default([]) List<BookComment> replies,
    required int totalComments,
    required bool hasMore,
    String? lastDocumentId,
  }) = _CommentsList;

  factory CommentsList.fromJson(Map<String, dynamic> json) =>
      _$CommentsListFromJson(json);
}

/// Timestamp converter for Freezed
class TimestampConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampConverter();

  @override
  DateTime fromJson(dynamic timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }
    if (timestamp is Timestamp) {
      return timestamp.toDate();
    }
    if (timestamp is int) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    if (timestamp is String) {
      return DateTime.parse(timestamp);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => Timestamp.fromDate(dateTime);
}

/// Extension methods for BookComment
extension BookCommentExtensions on BookComment {
  /// Check if user liked this comment
  bool isLikedBy(String userId) => likedBy.contains(userId);

  /// Check if this is a reply
  bool get isReply => parentCommentId != null;

  /// Check if comment can be edited (within 5 minutes)
  bool canEdit() {
    if (isEdited) return false; // Already edited once
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    return diff.inMinutes < 5;
  }

  /// Check if user owns this comment
  bool isOwnedBy(String userId) => this.userId == userId;

  /// Get time ago string
  String getTimeAgo() {
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds}s ago';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w ago';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()}mo ago';
    } else {
      return '${(diff.inDays / 365).floor()}y ago';
    }
  }
}
