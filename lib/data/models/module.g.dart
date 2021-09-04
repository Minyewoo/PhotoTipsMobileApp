// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) {
  return Module(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    (json['entries'] as List)
            ?.map((e) => e == null
                ? null
                : ModuleEntry.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    json['indexNumber'] as int,
  );
}

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'id': instance.id,
      'indexNumber': instance.indexNumber,
      'name': instance.name,
      'description': instance.description,
      'entries': instance.entries,
    };
