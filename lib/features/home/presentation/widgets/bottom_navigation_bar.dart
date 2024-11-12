import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/core/themes/color_manager.dart';
import 'package:socially/features/home/presentation/blocs/bottom_bar_cubit/bottom_bar_cubit.dart';
import 'package:socially/features/home/presentation/widgets/bottom_navigation_bar_item.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BlocBuilder<BottomBarCubit, int>(
        builder: (context, currentIndex) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (index) => _buildBottomBarItem(context, index, currentIndex),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomBarItem(
    BuildContext context,
    int index,
    int currentIndex,
  ) {
    final cubit = context.read<BottomBarCubit>();

    return BottomNavBarItem(
      onTap: () => cubit.changeIndex(index, context),
      iconSrc: cubit.selectedAssets[index],
      colorFilter: ColorFilter.mode(
        currentIndex == index ? ColorManager.primary : ColorManager.gray,
        BlendMode.srcIn,
      ),
    );
  }
}
