import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.onChanged,
    required this.hintText,
    this.controller,
    this.inputFormatters,
    this.radius = 8,
    this.suffix,
    this.maxLines = 1,
    this.borderColor,
    this.textAlign,
    this.style,
    this.obscureText = false,
    this.keyboardType,
  });
  final Function(String)? onChanged;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Widget? suffix;
  final double radius;
  final int maxLines;
  final Color? borderColor;
  final TextAlign? textAlign;
  final TextStyle? style;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxLines,
      obscureText: widget.obscureText,
      style: widget.style ??
          AppTextStyles.s15W600(
            color: Colors.black,
          ),
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: widget.suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            width: 1,
            color: widget.borderColor ?? AppColors.color38B6FFBLue,
          ),
        ),
        hintText: widget.hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            width: 1,
            color: widget.borderColor ?? AppColors.color38B6FFBLue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: BorderSide(
            width: 1,
            color: widget.borderColor ?? AppColors.color38B6FFBLue,
          ),
        ),
      ),
    );
  }
}
