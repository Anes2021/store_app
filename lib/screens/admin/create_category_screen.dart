// ignore_for_file: use_build_context_synchronously

import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldpriceController = TextEditingController();
  final List<String> priceTiles = ['false', 'true'];
  final List<String> categoryTiles = [
    'category1',
    'category2',
    'category3',
    'category4',
    'category5'
  ];
  String? priceSelectedTile;
  String? categorySelectedTile;
  bool isDiscounted = false;
  double? discountPercantage;

  @override
  void initState() {
    priceSelectedTile = priceTiles[0];
    categorySelectedTile = categoryTiles[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // Ensure full height
          ),
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gap(30.h),
                appBar(),
                Gap(20.h),
                imagePickUpContainer(),
                Gap(10.h),
                textFields(),
                Gap(10.h),
                previewCategory(),
                Gap(50.h),
                GestureDetector(
                  onTap: () async {
                    await createCategoryShop();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.backgroundColorGrey01, width: 2)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(child: Text("Create Item Shop")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.backgroundColorGrey01,
                width: 1.5.sp,
              ),
              borderRadius: BorderRadius.circular(10.sp),
              color: AppColors.backgroundColorOne,
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.orange,
              ),
            ),
          ),
        ),
        Gap(10.w),
        Text(
          "Create Category",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget imagePickUpContainer() {
    return Container(
      width: double.infinity,
      height: 150.h,
      decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(color: AppColors.backgroundColorGrey01, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_rounded,
            size: 40.sp,
            color: AppColors.backgroundColorGrey02,
          ),
          Text(
            "Add Photo to The Category.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.backgroundColorGrey02, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget textFields() {
    return Column(
      children: [
        TextFieldModel(
          controller: titleController,
          hintText: "put title here",
          function: (String text) {},
        ),
      ],
    );
  }

  Widget previewCategory() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Previews",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Gap(5.w),
            Expanded(
              child: Container(
                height: 1.h,
                color: AppColors.backgroundColorGrey02,
              ),
            ),
          ],
        ),
        Gap(10.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.backgroundColorGrey01, width: 1.5),
              color: AppColors.backgroundColorGrey03),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                    width: double.infinity.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppColors.backgroundColorTwo)),
                Gap(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1.5),
                          color: Colors.black.withOpacity(0.4)),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.grid_view_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Gap(10.w),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 1.5),
                          color: Colors.black),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.view_agenda,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> createCategoryShop() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String id = const Uuid().v4();

    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        int.tryParse(priceController.text) == null) {
      CherryToast.error(
        description: Text(
          "please fill all informations",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
      return;
    } else {
      ShopItemModel shopItemModel = ShopItemModel(
        createdAt: DateTime.now(),
        itemId: id,
        title: titleController.text,
        description: descriptionController.text,
        imageUrl: '',
        price: int.tryParse(priceController.text) ?? 0, // Handle null safely
        discount: isDiscounted,
        likes: 0,
        priceAfterDiscount: int.tryParse(oldpriceController.text) ?? 0,
        views: 0,
        category: categorySelectedTile ?? 'Unknown', // Fallback for null safety
      );
      await fireStore
          .collection("items_shop")
          .doc(id)
          .set(shopItemModel.toJson());
      CherryToast.success(
        description: Text(
          "product added successfully",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: AppColors.backgroundColorGrey03,
              ),
        ),
      ).show(context);
      Navigator.of(context).pop();
    }
  }
}
