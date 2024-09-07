import 'dart:developer';

import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class CreateItemShopScreen extends StatefulWidget {
  const CreateItemShopScreen({super.key});

  @override
  State<CreateItemShopScreen> createState() => _CreateItemShopScreenState();
}

class _CreateItemShopScreenState extends State<CreateItemShopScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController oldpriceController = TextEditingController();
  final List<String> tiles = ['false', 'true'];
  String? selectedTile;
  bool isDiscounted = false;

  double? discountPercantage;
  @override
  void initState() {
    selectedTile = tiles[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              priceZone(),
              ElevatedButton(
                  onPressed: () async {
                    await createItemShop();
                  },
                  child: const Text("Create Item Shop")),
            ],
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
            )),
        Gap(10.w),
        Text(
          "Create Item in Shop",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget imagePickUpContainer() {
    return Container(
      width: double.infinity,
      height: 100.h,
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
            "Add Photos to The Product.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.backgroundColorGrey02, fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget textFields() {
    return Column(children: [
      TextFieldModel(
        controller: titleController,
        hintText: "put title here",
        function: (String text) {},
      ),
      Gap(10.h),
      TextFieldModel(
        controller: descriptionController,
        hintText: "put description here",
        function: (String text) {},
      ),
    ]);
  }

  Widget priceZone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Price Zone",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp),
            ),
            Gap(5.w),
            Expanded(
                child: Container(
              height: 1.h,
              color: AppColors.backgroundColorGrey02,
            )),
          ],
        ),
        Gap(10.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFieldModel(
                keyboardType: TextInputType.number,
                controller: priceController,
                hintText: (isDiscounted == false) ? "Add Price" : "Old Price",
                enabled: (isDiscounted == true) ? false : true,
                function: (String text) {},
              ),
            ),
            Gap(10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColorGrey03,
                  border: Border.all(
                    color: AppColors.backgroundColorGrey01, // Border color
                    width: 1.5, // Border width
                  ),

                  borderRadius:
                      BorderRadius.circular(10.0), // Adds rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "discount:",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      Expanded(
                        child: ListTile(
                          minTileHeight: 49,
                          trailing: DropdownButton<String>(
                            value: selectedTile,
                            items: tiles
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Colors.orange),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTile = newValue;
                                if (selectedTile == tiles[0]) {
                                  isDiscounted = false;
                                } else {
                                  isDiscounted = true;
                                }
                                log(isDiscounted.toString());
                              });
                            },
                            underline: Container(),
                            iconSize: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(10.h),
        isDiscounted
            ? Row(
                children: [
                  Expanded(
                    child: TextFieldModel(
                      keyboardType: TextInputType.number,
                      controller: oldpriceController,
                      hintText: "Price After Discounting",
                      function: (String newPrice) {
                        // int newprice = int.tryParse(newPrice)!;
                        int price = int.tryParse(priceController.text)!;
                        int? newPrice =
                            (int.tryParse(oldpriceController.text) ?? 0);
                        if (newPrice > price || newPrice < 0) {
                          CherryToast.error(
                              description: Text(
                            "new price need be smaller than $price and bigger than 00",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 13.sp,
                                    color: AppColors.backgroundColorGrey03),
                          )).show(context);
                        } else {
                          discountPercantage =
                              (((price - newPrice) / price) * (100))
                                  .roundToDouble();
                          log(discountPercantage.toString());
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Gap(10.h),
                  SizedBox(
                    width: 65.w,
                    child: Center(
                      child: TextFieldModel(
                        function: (newPrice) {},
                        enabled: false,
                        controller: TextEditingController(),
                        hintText: "$discountPercantage",
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
        Gap(10.h),
        Row(
          children: [
            Text(
              "Add To Category",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp),
            ),
            Gap(5.w),
            Expanded(
                child: Container(
              height: 1.h,
              color: AppColors.backgroundColorGrey02,
            )),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColorGrey03,
                  border: Border.all(
                    color: AppColors.backgroundColorGrey01, // Border color
                    width: 1.5, // Border width
                  ),

                  borderRadius:
                      BorderRadius.circular(10.0), // Adds rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "discount:",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      Expanded(
                        child: ListTile(
                          minTileHeight: 49,
                          trailing: DropdownButton<String>(
                            value: selectedTile,
                            items: tiles
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(color: Colors.orange),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedTile = newValue;
                                if (selectedTile == tiles[0]) {
                                  isDiscounted = false;
                                } else {
                                  isDiscounted = true;
                                }
                                log(isDiscounted.toString());
                              });
                            },
                            underline: Container(),
                            iconSize: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> createItemShop() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String id = const Uuid().v4();
    ShopItemModel shopItemModel = ShopItemModel(
      createdAt: DateTime.now(),
      itemId: id,
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: '',
      price: 100,
      discount: true,
      isLiked: false,
      likes: 10,
      oldPrice: 120,
      views: 961,
      category: selectedTile!,
    );
    await fireStore
        .collection("items_shop")
        .doc(id)
        .set(shopItemModel.toJson());
  }
}
