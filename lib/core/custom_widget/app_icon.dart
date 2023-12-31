import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.iconColor,
    this.iconSize,
  });
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: iconColor ?? context.them.iconAndTextColor,
      size: iconSize?.w ?? 7.w,
    );
  }
}
