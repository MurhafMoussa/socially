import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/core/app/depndency_injection.dart';
import 'package:socially/features/home/presentation/views/home_view.dart';
import 'package:socially/features/post/domain/models/story_model/story_model.dart';
import 'package:socially/features/post/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:socially/features/post/presentation/blocs/story_bloc/story_bloc.dart';
import 'package:socially/features/post/presentation/views/post_view.dart';
import 'package:socially/features/post/presentation/views/story_view.dart';
import 'package:socially/features/splash/presentation/views/splash_view.dart';

class RoutesNames {
  static const String splashRoute = '/';

  static const String homeRoute = '/home';
  static const String storyRoute = '/story';
  static const String exploreRoute = '/explore';
  static const String profileRoute = '/profile';
}

class RoutesPaths {
  static const String splashRoute = '/';

  static const String homeRoute = '/home';
  static const String storyRoute = 'story';

  static const String exploreRoute = '/explore';
  static const String profileRoute = '/profile';
}

class NavigationKeys {
  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
}

class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: NavigationKeys.rootNavigatorKey,
    initialLocation: RoutesPaths.splashRoute,
    routes: [
      GoRoute(
        name: RoutesNames.splashRoute,
        path: RoutesPaths.splashRoute,
        builder: (context, state) => const SplashView(),
      ),
      ShellRoute(
        navigatorKey: NavigationKeys.shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 1140),
            child: HomeView(child: child),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation.drive(
                  CurveTween(
                    curve: Curves.easeInOut, // Smooth fade effect
                  ),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.95, // Slightly zoomed out at the start
                    end: 1, // Full scale at the end
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut, // Smooth scale effect
                    ),
                  ),
                  child: child,
                ),
              );
            },
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: NavigationKeys.shellNavigatorKey,
            name: RoutesNames.homeRoute,
            path: RoutesPaths.homeRoute,
            builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider<StoryBloc>(
                  create: (context) => getIt<StoryBloc>(),
                ),
                BlocProvider<PostBloc>(
                  create: (context) => getIt<PostBloc>(),
                ),
              ],
              child: const PostView(),
            ),
            routes: [
              GoRoute(
                parentNavigatorKey: NavigationKeys.rootNavigatorKey,
                name: RoutesNames.storyRoute,
                path: RoutesPaths.storyRoute,
                builder: (context, state) {
                  final story = state.extra! as StoryModel;
                  return StoryView(
                    storyModel: story,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: NavigationKeys.shellNavigatorKey,
            name: RoutesNames.exploreRoute,
            path: RoutesPaths.exploreRoute,
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            parentNavigatorKey: NavigationKeys.shellNavigatorKey,
            name: RoutesNames.profileRoute,
            path: RoutesPaths.profileRoute,
            builder: (context, state) => const SizedBox(),
          ),
        ],
      ),
    ],
  );
}
