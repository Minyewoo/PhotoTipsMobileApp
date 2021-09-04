// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    json['id'] as String,
    json['fileUrl'] as String,
    json['thumbnailUrl'] as String,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'fileUrl': instance.fileUrl,
      'thumbnailUrl': instance.thumbnailUrl,
    };
