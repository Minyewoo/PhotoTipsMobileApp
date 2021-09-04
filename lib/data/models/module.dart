import 'package:json_annotation/json_annotation.dart';

import 'module_entry.dart';

part 'module.g.dart';

@JsonSerializable()
class Module {
  final int id;
  final int indexNumber;
  final String name;
  final String description;

  @JsonKey(defaultValue: <ModuleEntry>[])
  final List<ModuleEntry> entries;

  const Module(this.id, this.name, this.description, this.entries, this.indexNumber);

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
