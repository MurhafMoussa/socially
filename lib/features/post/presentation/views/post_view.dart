import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/core/app/depndency_injection.dart';
import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/routers/routes_manager.dart';
import 'package:socially/core/themes/color_manager.dart';
import 'package:socially/features/post/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:socially/features/post/presentation/blocs/story_bloc/story_bloc.dart';
import 'package:socially/features/post/presentation/widgets/post_item_widget.dart';
import 'package:socially/features/post/presentation/widgets/story_item_widget.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyBloc = getIt<StoryBloc>();
    final postBloc = getIt<PostBloc>();
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s26),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppSizeH.s10),
              height: AppSizeH.s75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.storyBackGround1,
                    ColorManager.storyBackGround2,
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSizeR.s48),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizeR.s48),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: storyBloc.initialStories.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: AppSizeW.s7_5,
                          ).copyWith(
                            start: index == 0 ? AppSizeW.s10 : AppSizeW.s7_5,
                          ),
                          child: BlocBuilder<StoryBloc, StoryState>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  context.goNamed(
                                    RoutesNames.storyRoute,
                                    extra: state.stories[index],
                                  );
                                },
                                child: StoryItemWidget(
                                  story: state.stories[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppSizeH.s12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizeW.s13),
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) => ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppSizeH.s12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: postBloc.posts.length,
                itemBuilder: (context, index) {
                  return PostItemWidget(post: postBloc.posts[index]);
                },
              ),
            ),
          ),
          SizedBox(height: AppSizeH.s12),
        ],
      ),
    );
  }
}
