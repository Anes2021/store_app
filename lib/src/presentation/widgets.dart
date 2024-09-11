import 'package:balagh/src/core/app_color.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

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
        prefixIcon: const Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: AppColors.backgroundColorGrey01,
          size: 20,
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: AppColors.backgroundColorGrey01, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey03, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
              color: AppColors.backgroundColorGrey03, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        filled: true,
        fillColor: AppColors.backgroundColorTwo,
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
      ),
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: AppColors.backgroundColorGrey02),
    );
  }
}

class ItemShopComments extends StatelessWidget {
  const ItemShopComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    color: Colors.orange,
                    border: Border.all(color: Colors.black, width: 1.5)),
              ),
              Gap(10.w),
              Text("UserName", style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text("2024/09/10",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.backgroundColorGrey03,
                      fontSize: 13,
                      fontWeight: FontWeight.normal)),
              const Spacer(),
              Text("(5.0)",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.backgroundColorGrey03,
                      fontSize: 11,
                      fontWeight: FontWeight.normal)),
              const Icon(
                Icons.star_rate_rounded,
                size: 20,
                color: Colors.orange,
              )
            ],
          ),
          Gap(3.h),
          Row(
            children: [
              Expanded(
                child: Text("Comment Here  ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.backgroundColorGrey03,
                        fontSize: 15,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
          Gap(10.h),
          Container(
              height: 1.h, width: 150, color: AppColors.backgroundColorGrey02),
        ],
      ),
    );
  }
}
