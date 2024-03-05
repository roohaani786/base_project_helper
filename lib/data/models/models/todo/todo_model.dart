import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {

  int? userId;

  int? id;

  String? title;

  bool? completed;

  TodoModel(
     this.userId,
     this.id,
     this.title,
     this.completed,
  );

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
