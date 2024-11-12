import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/themes/color_manager.dart';
import 'package:socially/features/post/domain/models/post_model/post_model.dart';
import 'package:socially/features/post/presentation/views/comment_view.dart';
import 'package:socially/features/post/presentation/widgets/image_post_widget.dart';
import 'package:socially/features/post/presentation/widgets/tag_widget.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({
    super.key,
    required this.post,
  });
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizeW.s13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizeR.s20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 0),
            blurRadius: AppSizeR.s9,
            color: ColorManager.black.withOpacity(.25),
          ),
        ],
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          UserInfoRow(post: post),
          SizedBox(height: AppSizeH.s8),
          ImagePostWidget(images: post.images),
          SizedBox(height: AppSizeH.s8),
          PostText(postText: post.post),
          SizedBox(height: AppSizeH.s8),
          PostTags(tags: post.tags),
          SizedBox(height: AppSizeH.s8),
          Divider(color: ColorManager.gray, height: AppSizeH.s1),
          SizedBox(height: AppSizeH.s13),
          PostActions(post: post),
        ],
      ),
    );
  }
}

// User information row at the top of the post
class UserInfoRow extends StatelessWidget {
  const UserInfoRow({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSizeW.s12,
                backgroundImage: AssetImage(post.imageUser),
              ),
              SizedBox(width: AppSizeW.s8),
              Text(
                post.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              if (post.tagName != null) ...[
                SizedBox(width: AppSizeW.s2),
                Text(
                  '.With ${post.tagName}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: AppSizeW.s10),
        Text(
          post.time,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ],
    );
  }
}

// Widget to display the main post text
class PostText extends StatelessWidget {
  const PostText({super.key, required this.postText});
  final String postText;

  @override
  Widget build(BuildContext context) {
    return Text(
      postText,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

// Widget to display tags at the bottom of the post
class PostTags extends StatelessWidget {
  const PostTags({super.key, required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: tags.take(3).map((tag) {
            return Padding(
              padding: EdgeInsetsDirectional.only(end: AppSizeW.s7),
              child: TagWidget(iconSrc: IconAssets.tag, text: tag),
            );
          }).toList(),
        ),
        if (tags.length >= 3) SvgPicture.asset(IconAssets.moreThree),
      ],
    );
  }
}

// Widget for post actions like likes, comments, and save icon
class PostActions extends StatelessWidget {
  const PostActions({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizeW.s13),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ActionItem(
                  icon: IconAssets.loveUnselected,
                  count: post.likesCount,
                ),
                SizedBox(width: AppSizeW.s10),
                GestureDetector(
                  onTap: () => _showComments(context),
                  child: ActionItem(
                    icon: IconAssets.comment,
                    count: post.commentsCount,
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(IconAssets.saved),
        ],
      ),
    );
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => CommentView(post: post),
    );
  }
}

// Widget for individual action items (like, comment) with icon and count
class ActionItem extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.icon,
    required this.count,
  });

  final String icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: AppSizeW.s7),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
