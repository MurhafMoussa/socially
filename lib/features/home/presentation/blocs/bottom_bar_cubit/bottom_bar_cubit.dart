import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/core/routers/routes_manager.dart';

class BottomBarCubit extends Cubit<int> {
  BottomBarCubit() : super(0);

  List<String> paths = [
    RoutesNames.homeRoute,
    RoutesNames.exploreRoute,
    RoutesNames.profileRoute,
  ];

  List<String> selectedAssets = [
    IconAssets.home,
    IconAssets.explore,
    IconAssets.profile,
  ];

  void changeIndex(int newIndex, BuildContext context) {
    emit(newIndex);
    context.goNamed(paths[newIndex]);
  }
}
