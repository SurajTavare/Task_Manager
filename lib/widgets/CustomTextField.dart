import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? prefixIcon;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool isSearch;
  final ValueChanged<String>? onChanged;
  final bool? isDense;


  const CustomTextField({
    super.key,
    this.isDense,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.sentences,
    this.contentPadding =
    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    this.borderRadius = 20,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.textColor = const Color(0xFF2D3142),
    this.isSearch = false,
    this.onChanged,

  });

  @override
  Widget build(BuildContext context) {
    return TextField(

      controller: controller,
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
      ),
      decoration: InputDecoration(
        isDense: isDense,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: fontSize - 1,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: Colors.purple.shade300,
          size: 22,
        )
            : null,
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: Colors.purple.shade100,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.purple, width: 2),
        ),
      ),
    );
  }
}
