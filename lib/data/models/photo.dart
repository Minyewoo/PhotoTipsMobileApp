import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  final String id;
  final String fileUrl;
  final String thumbnailUrl;

  const Photo(this.id, this.fileUrl, this.thumbnailUrl);

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
