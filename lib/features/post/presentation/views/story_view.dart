import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/core/app/depndency_injection.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/utils/date_extensions.dart';
import 'package:socially/core/widgets/custom_image.dart';
import 'package:socially/features/post/domain/models/story_model/story_model.dart';
import 'package:socially/features/post/presentation/blocs/story_bloc/story_bloc.dart';
import 'package:socially/features/post/presentation/widgets/tag_widget.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.storyModel});
  final StoryModel storyModel;

  @override
  _StoryViewState createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _likeController;
  late Animation<double> _likeAnimation;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    // Controller for "like" animation
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(parent: _likeController, curve: Curves.elasticOut),
    );

    // Controller for story progress (screen dismissal)
    _progressController = AnimationController(
      duration: const Duration(seconds: 5), // Story duration
      vsync: this,
    );

    // Start the story progress
    _progressController
      ..forward()

      // When story progress completes, pop the screen
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.pop();
        }
      });
  }

  @override
  void dispose() {
    _likeController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    setState(() {
      isLiked = true;
    });
    _likeController.forward().then((_) => _likeController.reverse());
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLiked = false;
      });
    });
    getIt<StoryBloc>().add(
      StoryEvent.toggleLike(
        widget.storyModel.id,
        enforceFavorite: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onDoubleTap: _onDoubleTap,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.black.withOpacity(0.2),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
              Expanded(
                child: Stack(
                  children: [
                    StoryImageWithOverlay(story: widget.storyModel),
                    PositionedTopBar(storyModel: widget.storyModel),
                    PositionedTagWidget(tag: widget.storyModel.tag),
                    if (isLiked)
                      Center(
                        child: ScaleTransition(
                          scale: _likeAnimation,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red.withOpacity(0.8),
                            size: 100.sp,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for displaying image with top and bottom gradient overlays
class StoryImageWithOverlay extends StatelessWidget {
  const StoryImageWithOverlay({required this.story, super.key});
  final StoryModel story;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CustomImage.network(
          story.imageUrl,
          width: double.infinity,
          height: double.infinity,
        ),
        const TopBottomGradients(),
        PositionedLoveIcon(
          storyModel: story,
        ),
      ],
    );
  }
}

// Widget for top and bottom gradient overlays
class TopBottomGradients extends StatelessWidget {
  const TopBottomGradients({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientOverlay(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          height: 100.h,
        ),
        const Spacer(),
        GradientOverlay(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          height: 100.h,
        ),
      ],
    );
  }
}

class GradientOverlay extends StatelessWidget {
  const GradientOverlay({
    super.key,
    required this.begin,
    required this.end,
    required this.height,
  });
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0),
          ],
        ),
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
      ),
    );
  }
}

// Widget for love icon positioned at the bottom right
class PositionedLoveIcon extends StatelessWidget {
  const PositionedLoveIcon({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, StoryState>(
      bloc: getIt<StoryBloc>(),
      builder: (context, state) {
        final story = state.stories
            .where(
              (element) => element.id == storyModel.id,
            )
            .first;
        return InkWell(
          onTap: () {
            getIt<StoryBloc>().add(StoryEvent.toggleLike(story.id));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizeW.s15,
              vertical: AppSizeH.s40,
            ),
            child: Icon(
              story.isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}

// Widget for the top bar with back button, user info, and download icon
class PositionedTopBar extends StatelessWidget {
  const PositionedTopBar({super.key, required this.storyModel});
  final StoryModel storyModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizeW.s19,
        vertical: AppSizeH.s15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(IconAssets.back),
              ),
              SizedBox(width: AppSizeW.s10),
              Text(
                storyModel.userName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: AppSizeW.s10),
              Text(
                storyModel.elapsedTime.timeAgo(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          SvgPicture.asset(IconAssets.download),
        ],
      ),
    );
  }
}

// Widget for displaying the tag at the bottom
class PositionedTagWidget extends StatelessWidget {
  const PositionedTagWidget({super.key, required this.tag});
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppSizeH.s160,
      right: AppSizeW.s50,
      child: TagWidget(
        iconSrc: IconAssets.tag,
        text: tag,
      ),
    );
  }
}
