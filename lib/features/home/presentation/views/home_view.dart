import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socially/core/constants/assets_manager.dart';
import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/themes/color_manager.dart';
import 'package:socially/features/home/presentation/blocs/bottom_bar_cubit/bottom_bar_cubit.dart';
import 'package:socially/features/home/presentation/widgets/bottom_navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.child});
  final Widget child;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizeW.s24),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.logo),
                ],
              ),
              SvgPicture.asset(IconAssets.notification),
            ],
          ),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BlocProvider(
        create: (context) => BottomBarCubit(),
        child: ClipRRect(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(AppSizeR.s20),
            topEnd: Radius.circular(AppSizeR.s20),
          ),
          child: const BottomNavigationBarWidget(),
        ),
      ),
    );
  }
}
