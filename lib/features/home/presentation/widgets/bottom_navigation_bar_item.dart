import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarItem extends StatelessWidget {
  const BottomNavBarItem({
    super.key,
    required this.iconSrc,
    this.onTap,
    this.colorFilter,
  });
  final String iconSrc;
  final Function()? onTap;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(iconSrc, colorFilter: colorFilter),
            ),
            // Text(title, style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
