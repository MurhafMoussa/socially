import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:socially/core/constants/values_manager.dart';
import 'package:socially/core/themes/color_manager.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    super.key,
    required this.iconSrc,
    required this.text,
  });
  final String iconSrc;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizeW.s8),
      decoration: BoxDecoration(
          color: ColorManager.backgroundContainer,
          borderRadius: BorderRadius.circular(AppSizeR.s20),),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconSrc),
          SizedBox(width: AppSizeW.s4),
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
