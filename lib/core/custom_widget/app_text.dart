import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.fontFamily,
    this.fontSize,
    this.isBold = false,
    this.latterSpacing,
    this.textColor,
  });
  final String text;
  final double? fontSize;
  final Color? textColor;
  final String? fontFamily;
  final bool isBold;
  final double? latterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor ?? context.them.iconAndTextColor,
        fontWeight: isBold ? FontWeight.bold : null,
        letterSpacing: latterSpacing,
        fontFamily: fontFamily,
        fontSize: fontSize?.sp ?? 16.sp,
      ),
    );
  }
}
