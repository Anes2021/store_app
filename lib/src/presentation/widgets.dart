import 'package:balagh/src/core/app_color.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

class TextFieldModel extends StatelessWidget {
  const TextFieldModel({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.enabled,
    required this.function,
    this.colors,
    this.textFieldHeight,
    this.maxLines,
    this.minLines,
  });
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final Function(String text) function;
  final bool? enabled;
  final int? textFieldHeight;
  final TextEditingController controller;
  final String hintText;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      onChanged: (
        String text,
      ) {
        function(
          text,
        );
      },
      keyboardType: keyboardType,
      enabled: enabled ?? true,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.backgroundColorGrey01),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey02, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.backgroundColorGrey03,
        contentPadding: EdgeInsets.symmetric(
            vertical: (textFieldHeight ?? 15).asDouble(), horizontal: 10),
      ),
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: colors ?? AppColors.backgroundColorGrey02),
    );
  }
}

class TextFieldSearchModel extends StatelessWidget {
  const TextFieldSearchModel(
      {super.key, required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:
            const Icon(Icons.search, color: AppColors.backgroundColorGrey01),
        suffixIcon:
            const Icon(Icons.tune, color: AppColors.backgroundColorGrey01),
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.backgroundColorGrey01),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey01, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.backgroundColorGrey03,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
      ),
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: AppColors.backgroundColorGrey02),
    );
  }
}
