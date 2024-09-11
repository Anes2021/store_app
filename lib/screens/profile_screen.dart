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
            welcomeSign(),
            Gap(10.h),
            settingsTiles(),
            Gap(10.h),
            settingsTiles2(),
            Gap(10.h),
            contactUs()
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

  Widget welcomeSign() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: double.infinity.w,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.backgroundColorTwo),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
                  color: AppColors.backgroundColorOne,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Image.asset(
                      "assets/images/person_icon.png",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Anes!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 20.sp),
                ),
                Text("Modifie your account settings here.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp, fontWeight: FontWeight.normal))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget settingsTile(
      String title, Function() function, IconData icon, Color? color) {
    return Container(
      width: double.infinity.w,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(0.25),
              ),
              child: Center(
                  child: Icon(
                icon,
                color: color,
                size: 25,
              )),
            ),
            Gap(10.w),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 17, color: color)),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget settingsTiles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          width: double.infinity.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.backgroundColorTwo),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      settingsTile("Profile Settings", () {}, Icons.person_2,
                          Colors.white),
                      Gap(2.h),
                      settingsTile("My Cart", () {},
                          Icons.shopping_cart_rounded, Colors.white),
                      Gap(2.h),
                      settingsTile("My Favorite", () {}, Icons.favorite_rounded,
                          Colors.white),
                      Gap(2.h),
                      settingsTile(
                          "Rate Application", () {}, Icons.star, Colors.white),
                      Gap(2.h),
                      settingsTile("Help Center", () {}, Icons.help_rounded,
                          Colors.white),
                    ],
                  ))
            ],
          )),
    );
  }

  Widget settingsTiles2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
          width: double.infinity.w,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.backgroundColorTwo),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      settingsTile("Language", () {}, Icons.language_rounded,
                          Colors.white),
                      Gap(2.h),
                      settingsTile("Dark Mode", () {}, Icons.dark_mode_rounded,
                          Colors.white),
                      Gap(2.h),
                      settingsTile("Privacy Policy", () {},
                          Icons.privacy_tip_rounded, Colors.white),
                      Gap(2.h),
                      settingsTile(
                          "Delete Account",
                          () {},
                          Icons.delete_forever_rounded,
                          const Color.fromARGB(255, 252, 1, 1)),
                    ], //
                  ))
            ],
          )),
    );
  }

  Widget contactUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Follow Us:"),
        Gap(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.facebook_rounded,
              color: Colors.orange,
              size: 25,
            ),
            Gap(10.w),
            const Icon(
              Icons.facebook_rounded,
              color: Colors.orange,
              size: 25,
            ),
            Gap(10.w),
            const Icon(
              Icons.facebook_rounded,
              color: Colors.orange,
              size: 25,
            ),
            Gap(10.w),
            const Icon(
              Icons.facebook_rounded,
              color: Colors.orange,
              size: 25,
            ),
            Gap(10.w),
            const Icon(
              Icons.facebook_rounded,
              color: Colors.orange,
              size: 25,
            ),
            Gap(10.w)
          ],
        ),
        Gap(30.h)
      ],
    );
  }
}
