import 'package:json_annotation/json_annotation.dart';

part 'lecture_content.g.dart';

enum ContentType {
  @JsonValue("Text")
  Text,
  @JsonValue("Image")
  Image,
  @JsonValue("Video")
  Video,
}

@JsonSerializable()
class LectureContent {
  final int id;
  final int indexNumber;
  final ContentType type;
  final String content;

  const LectureContent(this.id, this.type, this.content, this.indexNumber);

  factory LectureContent.fromJson(Map<String, dynamic> json) =>
      _$LectureContentFromJson(json);

  Map<String, dynamic> toJson() => _$LectureContentToJson(this);
}
