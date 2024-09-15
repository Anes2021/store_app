import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoryDetailedScreen extends StatefulWidget {
  const CategoryDetailedScreen({super.key, required this.categoryModel});

  @override
  State<CategoryDetailedScreen> createState() => _CategoryDetailedScreenState();

  final CategoryModel categoryModel;
}

class _CategoryDetailedScreenState extends State<CategoryDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      width: double.infinity.w,
      decoration: BoxDecoration(
        color: AppColors.backgroundColorOne,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            spreadRadius: 5, // How much the shadow spreads
            blurRadius: 30, // Softens the shadow
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "My Orders",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
