import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
@HiveType(typeId: 0) // Use a unique typeId
abstract class CommentModel with _$CommentModel {
  factory CommentModel({
    @HiveField(0) @Default(0) int postId,
    @HiveField(1) @Default(0) int id,
    @HiveField(2) @Default('') String name,
    @HiveField(3) @Default('') String email,
    @HiveField(4) @Default('') String body,
  }) = _CommentModel;
  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
