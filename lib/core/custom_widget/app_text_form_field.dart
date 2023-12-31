import 'package:final_project/core/extension/context.dart';
import 'package:final_project/core/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.textController,
    this.colorBorder,
    this.hintText,
    this.isFill = true,
    this.label,
    this.prefix,
    this.suffix,
    this.validate,
    this.horizontalPadding,
    this.verticalPadding,
    this.isShowContent = false,
    this.isReadOnly = false,
    this.onTap,
    this.inputFormatters,
    this.maxLine,
  });
  final TextEditingController textController;
  final Color? colorBorder;
  final String? hintText;
  final String? label;
  final bool isFill;
  final String? Function(String? text)? validate;
  final Widget? suffix;
  final Widget? prefix;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isShowContent;
  final bool isReadOnly;
  final Function()? onTap;
  final int? maxLine;
  final List<TextInputFormatter>? inputFormatters;
  InputBorder border(
          {bool isErrorBorder = false, required BuildContext context}) =>
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.w),
          borderSide: BorderSide(
            color: isErrorBorder
                ? Colors.red
                : colorBorder ?? context.them.iconAndTextColor,
          ));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 2.w,
        vertical: verticalPadding ?? 1.h,
      ),
      child: TextFormField(
        controller: textController,
        validator: validate,
        style: TextStyle(
          color: isFill ? Colors.black : context.them.iconAndTextColor,
        ),
        obscureText: isShowContent,
        readOnly: isReadOnly,
        onTap: onTap,
        maxLines: maxLine ?? (isShowContent ? 1 : null),
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          labelText: label,
          suffixIcon: suffix,
          prefixIcon: prefix,
          errorMaxLines: 3,
          filled: isFill,
          fillColor: isFill ? Colors.white : null,
          enabledBorder: border(context: context),
          focusedBorder: border(context: context),
          border: border(context: context),
          errorBorder: border(isErrorBorder: true, context: context),
        ),
      ),
    );
  }
}
