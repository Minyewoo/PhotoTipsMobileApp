// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['surname'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['residenceCity'] == null
        ? null
        : City.fromJson(json['residenceCity'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'residenceCity': instance.residenceCity,
    };
