import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/core/themes/color_manager.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.grey4,
      highlightColor: ColorManager.grey6,
      child: child,
    );
  }
}
