import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => CategoresScreenState();
}

class CategoresScreenState extends State<CategoriesScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            Gap(20.h),
            searchBar(),
            Gap(10.h),
            categories(),
            Gap(20.h),
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
            offset: const Offset(0, 5),
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
                  "Categories",
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

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 50.h,
              child: TextFieldSearchModel(
                  controller: searchController, hintText: "Search Here"),
            ),
          ),
          Gap(10.w),
          Container(
            width: 45.w,
            height: 45.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.orange,
            ),
            child: const Center(
                child: Icon(
              Icons.filter_list_rounded,
              size: 25,
              color: Colors.white,
            )),
          ),
        ],
      ),
    );
  }

  Widget categoryTile(String path, String name, int numberItems) {
    return Stack(
      children: [
        Container(
          height: ((MediaQuery.of(context).size.width - 70) / 2).w,
          width: ((MediaQuery.of(context).size.width - 70) / 2).w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: ((MediaQuery.of(context).size.width - 70) / 2).w,
          width: ((MediaQuery.of(context).size.width - 70) / 2).w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 14),
                ),
                Text(
                  "$numberItems Item",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 13, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget categories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          categoryTile("assets/categories_images/cpu_image.jpg", "CPUs", 38),
          categoryTile("assets/categories_images/pc_image.png", "PC", 43),
          categoryTile("assets/categories_images/mouse_image.png",
              "Mouses & Keyboards", 4),
          categoryTile("assets/categories_images/gpu_image.jpg", "GPUs", 432),
          categoryTile("assets/categories_images/rams_image.png", "Rams", 43),
          categoryTile(
              "assets/categories_images/camera_image.png", "Cameras", 08),
          categoryTile(
              "assets/categories_images/iphone_image.jpg", "Iphones", 648),
        ],
      ),
    );
  }
}
