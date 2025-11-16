// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookCommentImpl _$$BookCommentImplFromJson(Map<String, dynamic> json) =>
    _$BookCommentImpl(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      paragraphId: json['paragraphId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      userPhoto: json['userPhoto'] as String?,
      text: json['text'] as String,
      isPrivate: json['isPrivate'] as bool? ?? false,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      replies: (json['replies'] as num?)?.toInt() ?? 0,
      parentCommentId: json['parentCommentId'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      isEdited: json['isEdited'] as bool? ?? false,
      isReported: json['isReported'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookCommentImplToJson(_$BookCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'paragraphId': instance.paragraphId,
      'userId': instance.userId,
      'username': instance.username,
      'userPhoto': instance.userPhoto,
      'text': instance.text,
      'isPrivate': instance.isPrivate,
      'likes': instance.likes,
      'likedBy': instance.likedBy,
      'replies': instance.replies,
      'parentCommentId': instance.parentCommentId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.updatedAt, const TimestampConverter().toJson),
      'isEdited': instance.isEdited,
      'isReported': instance.isReported,
      'isDeleted': instance.isDeleted,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$ParagraphReportImpl _$$ParagraphReportImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphReportImpl(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      paragraphId: json['paragraphId'] as String,
      userId: json['userId'] as String,
      issueType: json['issueType'] as String,
      description: json['description'] as String,
      status: $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
          ReportStatus.pending,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      resolvedAt: const TimestampConverter().fromJson(json['resolvedAt']),
      resolvedBy: json['resolvedBy'] as String?,
      resolution: json['resolution'] as String?,
    );

Map<String, dynamic> _$$ParagraphReportImplToJson(
        _$ParagraphReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookId': instance.bookId,
      'paragraphId': instance.paragraphId,
      'userId': instance.userId,
      'issueType': instance.issueType,
      'description': instance.description,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'resolvedAt': _$JsonConverterToJson<dynamic, DateTime>(
          instance.resolvedAt, const TimestampConverter().toJson),
      'resolvedBy': instance.resolvedBy,
      'resolution': instance.resolution,
    };

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.reviewed: 'reviewed',
  ReportStatus.resolved: 'resolved',
  ReportStatus.dismissed: 'dismissed',
};

_$CommentActionResultImpl _$$CommentActionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$CommentActionResultImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      comment: json['comment'] == null
          ? null
          : BookComment.fromJson(json['comment'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CommentActionResultImplToJson(
        _$CommentActionResultImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'comment': instance.comment,
      'error': instance.error,
    };

_$CommentsListImpl _$$CommentsListImplFromJson(Map<String, dynamic> json) =>
    _$CommentsListImpl(
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => BookComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => BookComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalComments: (json['totalComments'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
      lastDocumentId: json['lastDocumentId'] as String?,
    );

Map<String, dynamic> _$$CommentsListImplToJson(_$CommentsListImpl instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'replies': instance.replies,
      'totalComments': instance.totalComments,
      'hasMore': instance.hasMore,
      'lastDocumentId': instance.lastDocumentId,
    };
