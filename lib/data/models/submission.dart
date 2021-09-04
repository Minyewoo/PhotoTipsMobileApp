import 'package:json_annotation/json_annotation.dart';
import 'package:photo_tips/data/models/photo.dart';

part 'submission.g.dart';

enum SubmissionStatus {
  @JsonValue('Checking')
  Checking,
  @JsonValue('Passed')
  Passed,
  @JsonValue('Rejected')
  Rejected
}

@JsonSerializable()
class Submission {
  final String id;
  final int moduleEntryId;
  final Photo photo;
  final SubmissionStatus status;
  final int mark;
  final String comment;
  final DateTime time;

  const Submission(
      this.id, this.moduleEntryId, this.photo, this.status, this.mark, this.comment, this.time);

  factory Submission.fromJson(Map<String, dynamic> json) => _$SubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$SubmissionToJson(this);
}
