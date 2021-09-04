// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureContent _$LectureContentFromJson(Map<String, dynamic> json) {
  return LectureContent(
    json['id'] as int,
    _$enumDecodeNullable(_$ContentTypeEnumMap, json['type']),
    json['content'] as String,
    json['indexNumber'] as int,
  );
}

Map<String, dynamic> _$LectureContentToJson(LectureContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexNumber': instance.indexNumber,
      'type': _$ContentTypeEnumMap[instance.type],
      'content': instance.content,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ContentTypeEnumMap = {
  ContentType.Text: 'Text',
  ContentType.Image: 'Image',
  ContentType.Video: 'Video',
};
