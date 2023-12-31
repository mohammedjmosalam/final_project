import 'package:final_project/core/custom_widget/app_text.dart';
import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:flutter/material.dart';

import 'app_icon.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.iconData,
    required this.onTap,
    required this.title,
    this.colorButton,
    this.sizeButton,
    this.titleColor,
  });
  final Function()? onTap;
  final String title;
  final IconData? iconData;
  final Color? colorButton;
  final Color? titleColor;
  final Size? sizeButton;
  ButtonStyle buttonStyle({required BuildContext context}) =>
      ElevatedButton.styleFrom(
        fixedSize: sizeButton,
        backgroundColor: colorButton ?? context.them.buttonColor,
      );

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return ElevatedButton.icon(
          style: buttonStyle(context: context),
          onPressed: onTap,
          icon: AppIcon(icon: iconData!),
          label: AppText(
            text: title,
            textColor: titleColor ?? Colors.white,
          ));
    }
    return ElevatedButton(
      onPressed: onTap,
      style: buttonStyle(context: context),
      child: AppText(
        text: title,
        textColor: titleColor ?? Colors.white,
      ),
    );
  }
}
