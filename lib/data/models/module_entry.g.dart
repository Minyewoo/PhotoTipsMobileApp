// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleEntry _$ModuleEntryFromJson(Map<String, dynamic> json) {
  return ModuleEntry(
    json['id'] as int,
    _$enumDecodeNullable(_$ModuleEntryTypeEnumMap, json['type']),
    json['name'] as String,
    (json['videoLecture'] as List)
            ?.map((e) => e == null
                ? null
                : LectureContent.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    (json['textLecture'] as List)
            ?.map((e) => e == null
                ? null
                : LectureContent.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['indexNumber'] as int,
    json['description'] as String,
    json['additionalInfo'] as String,
  );
}

Map<String, dynamic> _$ModuleEntryToJson(ModuleEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'indexNumber': instance.indexNumber,
      'type': _$ModuleEntryTypeEnumMap[instance.type],
      'name': instance.name,
      'description': instance.description,
      'additionalInfo': instance.additionalInfo,
      'videoLecture': instance.videoLecture,
      'textLecture': instance.textLecture,
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

const _$ModuleEntryTypeEnumMap = {
  ModuleEntryType.Lesson: 'Lesson',
  ModuleEntryType.Homework: 'Homework',
};
