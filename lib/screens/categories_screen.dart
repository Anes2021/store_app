import 'dart:developer';

import 'package:balagh/screens/admin/create_category_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/category_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
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
  bool gridVerticalView = false;
  final List<String> items = ["Most elements", "Best Seller"];
  String? selectedItem;

  late List<CategoryModel> listOfCategories = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    // Get all documents from the "categories" collection
    QuerySnapshot snapshot = await firestore.collection("categories").get();

    // Map each document into a CategoryModel
    listOfCategories = snapshot.docs.map((doc) {
      return CategoryModel.fromJson(doc.data()
          as Map<String, dynamic>); // Pass the data map from the document
    }).toList();
    setState(() {});
  }

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
            Gap(10.h),
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
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    gridVerticalView = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: !gridVerticalView
                          ? Colors.black
                          : Colors.black.withOpacity(0.25),
                      border: Border.all(color: Colors.black, width: 1.5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Gap(5.w),
              GestureDetector(
                onTap: () {
                  setState(() {
                    gridVerticalView = true;
                  });
                },
                child: Container(
                  decoration: gridVerticalView
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1.5),
                          color: Colors.black)
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black.withOpacity(0.25),
                          border: Border.all(color: Colors.black, width: 1.5)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Icon(
                      Icons.view_agenda,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              DropdownButton<String>(
                dropdownColor: AppColors.backgroundColorTwo,
                value: selectedItem,
                hint: Row(
                  children: [
                    Gap(5.w),
                    Text(
                      "Sort by",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.backgroundColorGrey03,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: AppColors.backgroundColorGrey03,
                ),
                onChanged: (String? newValue) {
                  log(newValue.toString());
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Gap(10.w),
                        Text(
                          value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Gap(20.w),
            ],
          ),
          Gap(10.h),
          Row(
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const CreateCategoryScreen()),
                  );
                },
                child: Container(
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryTile(String path, String name, int numberItems) {
    return Stack(
      children: [
        Container(
          height: ((MediaQuery.of(context).size.width - 40) / 2),
          width: gridVerticalView
              ? MediaQuery.of(context).size.width - 20
              : ((MediaQuery.of(context).size.width - 40) / 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: ((MediaQuery.of(context).size.width - 40) / 2),
          width: gridVerticalView
              ? MediaQuery.of(context).size.width - 20
              : ((MediaQuery.of(context).size.width - 40) / 2),
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
    return Wrap(
        spacing: 5,
        runSpacing: 5,
        crossAxisAlignment: WrapCrossAlignment.end,
        children: List.generate(listOfCategories.length, (index) {
          final item = listOfCategories[index];

          return categoryTile(item.imageUrl.toString(), item.title, 00);
        }));
  }
}
