// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submission _$SubmissionFromJson(Map<String, dynamic> json) {
  return Submission(
    json['id'] as String,
    json['moduleEntryId'] as int,
    json['photo'] == null
        ? null
        : Photo.fromJson(json['photo'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$SubmissionStatusEnumMap, json['status']),
    json['mark'] as int,
    json['comment'] as String,
    json['time'] == null ? null : DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$SubmissionToJson(Submission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moduleEntryId': instance.moduleEntryId,
      'photo': instance.photo,
      'status': _$SubmissionStatusEnumMap[instance.status],
      'mark': instance.mark,
      'comment': instance.comment,
      'time': instance.time?.toIso8601String(),
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

const _$SubmissionStatusEnumMap = {
  SubmissionStatus.Checking: 'Checking',
  SubmissionStatus.Passed: 'Passed',
  SubmissionStatus.Rejected: 'Rejected',
};
