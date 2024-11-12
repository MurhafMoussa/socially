import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_model.freezed.dart';
part 'story_model.g.dart';

@freezed
abstract class StoryModel with _$StoryModel {
  factory StoryModel({
    required int id,
    required String userImage,
    required DateTime elapsedTime,
    required String imageUrl,
    required String tag,
    required String userName,
    @Default(false) bool isLiked,
  }) = _StoryModel;
  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
}
