import 'package:flutter/material.dart';

import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/themes/color_manager.dart';
import 'package:socially/features/post/domain/models/story_model/story_model.dart';

class StoryItemWidget extends StatelessWidget {
  const StoryItemWidget({
    super.key,
    required this.story,
  });
  final StoryModel story;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizeH.s58,
      width: AppSizeH.s58,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: AppSizeW.s1, color: ColorManager.white),
          image: DecorationImage(image: AssetImage(story.userImage)),),
    );
  }
}
