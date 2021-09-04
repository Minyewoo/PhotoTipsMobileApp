import 'package:json_annotation/json_annotation.dart';

import 'lecture_content.dart';

part 'module_entry.g.dart';

enum ModuleEntryType {
  @JsonValue("Lesson")
  Lesson,
  @JsonValue("Homework")
  Homework,
}

@JsonSerializable()
class ModuleEntry {
  final int id;
  final int indexNumber;
  final ModuleEntryType type;
  final String name;
  final String description;
  final String additionalInfo;

  @JsonKey(defaultValue: <LectureContent>[])
  final List<LectureContent> videoLecture;

  @JsonKey(defaultValue: <LectureContent>[])
  final List<LectureContent> textLecture;

  const ModuleEntry(
      this.id, this.type, this.name, this.videoLecture, this.textLecture, this.indexNumber, this.description, this.additionalInfo);

  factory ModuleEntry.fromJson(Map<String, dynamic> json) =>
      _$ModuleEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleEntryToJson(this);
}
