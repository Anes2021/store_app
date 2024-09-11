import 'package:balagh/src/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            Gap(20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity.w,
                height: 125,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.backgroundColorTwo),
              ),
            )
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
                  "Profile Settings",
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
