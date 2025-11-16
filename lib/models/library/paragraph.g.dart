// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paragraph.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParagraphContentImpl _$$ParagraphContentImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphContentImpl(
      textAr: json['text_ar'] as String,
      textEn: json['text_en'] as String?,
    );

Map<String, dynamic> _$$ParagraphContentImplToJson(
        _$ParagraphContentImpl instance) =>
    <String, dynamic>{
      'text_ar': instance.textAr,
      'text_en': instance.textEn,
    };

_$ParagraphEntitiesImpl _$$ParagraphEntitiesImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphEntitiesImpl(
      people: (json['people'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      places: (json['places'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      dates:
          (json['dates'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$$ParagraphEntitiesImplToJson(
        _$ParagraphEntitiesImpl instance) =>
    <String, dynamic>{
      'people': instance.people,
      'places': instance.places,
      'events': instance.events,
      'dates': instance.dates,
    };

_$ParagraphSearchDataImpl _$$ParagraphSearchDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphSearchDataImpl(
      keywordsAr: (json['keywords_ar'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      keywordsEn: (json['keywords_en'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ParagraphSearchDataImplToJson(
        _$ParagraphSearchDataImpl instance) =>
    <String, dynamic>{
      'keywords_ar': instance.keywordsAr,
      'keywords_en': instance.keywordsEn,
    };

_$ParagraphReferencesImpl _$$ParagraphReferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphReferencesImpl(
      referencedInQuestions: (json['referenced_in_questions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relatedParagraphs: (json['related_paragraphs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ParagraphReferencesImplToJson(
        _$ParagraphReferencesImpl instance) =>
    <String, dynamic>{
      'referenced_in_questions': instance.referencedInQuestions,
      'related_paragraphs': instance.relatedParagraphs,
    };

_$QuestionPotentialImpl _$$QuestionPotentialImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionPotentialImpl(
      factsCount: (json['facts_count'] as num?)?.toInt() ?? 0,
      canGenerateQuestions: json['can_generate_questions'] as bool? ?? false,
    );

Map<String, dynamic> _$$QuestionPotentialImplToJson(
        _$QuestionPotentialImpl instance) =>
    <String, dynamic>{
      'facts_count': instance.factsCount,
      'can_generate_questions': instance.canGenerateQuestions,
    };

_$ParagraphMetadataImpl _$$ParagraphMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$ParagraphMetadataImpl(
      difficulty:
          $enumDecodeNullable(_$DifficultyLevelEnumMap, json['difficulty']) ??
              DifficultyLevel.basic,
      readingTimeSeconds: (json['reading_time_seconds'] as num?)?.toInt() ?? 0,
      questionPotential: json['question_potential'] == null
          ? null
          : QuestionPotential.fromJson(
              json['question_potential'] as Map<String, dynamic>),
      contentPriority: $enumDecodeNullable(
              _$ContentPriorityEnumMap, json['content_priority']) ??
          ContentPriority.medium,
    );

Map<String, dynamic> _$$ParagraphMetadataImplToJson(
        _$ParagraphMetadataImpl instance) =>
    <String, dynamic>{
      'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
      'reading_time_seconds': instance.readingTimeSeconds,
      'question_potential': instance.questionPotential,
      'content_priority': _$ContentPriorityEnumMap[instance.contentPriority]!,
    };

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.basic: 'basic',
  DifficultyLevel.intermediate: 'intermediate',
  DifficultyLevel.advanced: 'advanced',
  DifficultyLevel.expert: 'expert',
};

const _$ContentPriorityEnumMap = {
  ContentPriority.high: 'high',
  ContentPriority.medium: 'medium',
  ContentPriority.low: 'low',
};

_$ParagraphImpl _$$ParagraphImplFromJson(Map<String, dynamic> json) =>
    _$ParagraphImpl(
      id: json['id'] as String,
      bookId: json['book_id'] as String,
      sectionId: json['section_id'] as String,
      sectionTitleAr: json['section_title_ar'] as String,
      sectionTitleEn: json['section_title_en'] as String?,
      paragraphNumber: (json['paragraph_number'] as num).toInt(),
      pageNumber: (json['page_number'] as num).toInt(),
      content:
          ParagraphContent.fromJson(json['content'] as Map<String, dynamic>),
      entities: json['entities'] == null
          ? const ParagraphEntities()
          : ParagraphEntities.fromJson(
              json['entities'] as Map<String, dynamic>),
      searchData: json['search_data'] == null
          ? const ParagraphSearchData()
          : ParagraphSearchData.fromJson(
              json['search_data'] as Map<String, dynamic>),
      references: json['references'] == null
          ? const ParagraphReferences()
          : ParagraphReferences.fromJson(
              json['references'] as Map<String, dynamic>),
      metadata: json['metadata'] == null
          ? const ParagraphMetadata()
          : ParagraphMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ParagraphImplToJson(_$ParagraphImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'book_id': instance.bookId,
      'section_id': instance.sectionId,
      'section_title_ar': instance.sectionTitleAr,
      'section_title_en': instance.sectionTitleEn,
      'paragraph_number': instance.paragraphNumber,
      'page_number': instance.pageNumber,
      'content': instance.content,
      'entities': instance.entities,
      'search_data': instance.searchData,
      'references': instance.references,
      'metadata': instance.metadata,
      'created_at': instance.createdAt?.toIso8601String(),
    };
