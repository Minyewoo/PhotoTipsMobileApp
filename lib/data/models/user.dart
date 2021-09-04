import 'package:json_annotation/json_annotation.dart';
import 'package:photo_tips/data/models/city.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final City residenceCity;

  const User(
      this.name,
      this.surname,
      this.email,
      this.phoneNumber,
      this.residenceCity,);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
