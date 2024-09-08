// ignore_for_file: dead_code, use_build_context_synchronously

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
              Gap(10.h),
              GestureDetector(
                onTap: () async {
                  await createItemShop();
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
    );
  }

  Widget newProductsItem(String title, String description, int price,
      bool discount, int afterPrice, bool isNew) {
    return Stack(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width - 20.w - 10.w) / 2,
          decoration: BoxDecoration(
            border:
                Border.all(color: AppColors.backgroundColorGrey01, width: 1),
            color: AppColors.backgroundColorGrey03,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Gap(5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.backgroundColorGrey03,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey02),
                      ),
                      Gap(3.h),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      Gap(5.h),
                      discount
                          ? Text(
                              "$price\$",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.red[800],
                                    fontSize: 13.sp,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red[800],
                                    decorationThickness: 1.0,
                                  ),
                            )
                          : Gap(17.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              (discount) ? ("$afterPrice\$") : ("$price\$"),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: AppColors.backgroundColorGrey02),
                            ),
                          ),
                          Text(
                            '(0.0)',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Icon(
                            Icons.star_rate,
                            color: Colors.orange,
                            size: 27.sp,
                          )
                        ],
                      ),
                      Gap(10.h),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.orange, width: 1.5),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 25.sp,
                                color: Colors.orange,
                              ),
                            ),
                          )),
                          Gap(5.w),
                          Expanded(
                              child: Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Icon(
                                Icons.favorite_rounded,
                                size: 25.sp,
                                color: AppColors.backgroundColorGrey03,
                              ),
                            ),
                          )),
                        ],
                      ),
                      Gap(6.h)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          child: SizedBox(
            height: 50,
            width: 20,
            child: isNew
                ? Image.asset(
                    "assets/images/new_sign.png",
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        )
      ],
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
        maxLines: 3,
        textFieldHeight: 30,
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
                            value: priceSelectedTile,
                            items: priceTiles
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
                                if (priceController.text.trim().isEmpty) {
                                  CherryToast.error(
                                      description: Text(
                                    "please add price first then add a discount to it",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColors
                                                .backgroundColorGrey03),
                                  )).show(context);
                                  priceSelectedTile == priceTiles[0];
                                  isDiscounted = false;
                                  return;
                                } else if (int.tryParse(priceController.text)! <
                                    0) {
                                  priceController.text = "";
                                  CherryToast.error(
                                      description: Text(
                                    "please add price greater than 00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontSize: 13.sp,
                                            color: AppColors
                                                .backgroundColorGrey03),
                                  )).show(context);
                                  priceSelectedTile == priceTiles[0];
                                  isDiscounted = false;
                                  return;
                                } else {
                                  priceSelectedTile = newValue;
                                  if (priceSelectedTile == priceTiles[0]) {
                                    isDiscounted = false;
                                  } else {
                                    isDiscounted = true;
                                  }
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
            : Container(
                height: 0.h,
              ),
        Gap(5.h),
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
                        "Category",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      Expanded(
                        child: ListTile(
                          minTileHeight: 49,
                          trailing: DropdownButton<String>(
                            value: categorySelectedTile,
                            items: categoryTiles
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
                                categorySelectedTile = newValue;
                              });
                              CherryToast.info(
                                  description: Text(
                                "product category changed to $newValue",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 13.sp,
                                        color: AppColors.backgroundColorGrey03),
                              )).show(context);
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
        Row(
          children: [
            Text(
              "Preview",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.backgroundColorGrey03,
                  borderRadius: BorderRadius.circular(10.sp),
                  border: Border.all(
                      color: AppColors.backgroundColorGrey01, width: 1.5.sp)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: newProductsItem(
                        (titleController.text.trim().isEmpty)
                            ? "Product Title Here"
                            : (titleController.text),
                        (descriptionController.text.trim().isEmpty)
                            ? "Product Descrition Here"
                            : (descriptionController.text),
                        int.tryParse(priceController.text) ?? 0,
                        isDiscounted,
                        int.tryParse(oldpriceController.text) ?? 0,
                        true),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void cherrytoast(String text) {
    CherryToast.error(
        description: Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
    )).show(context);
  }

  Future<void> createItemShop() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    String id = const Uuid().v4();

    if (titleController.text.trim().isEmpty &&
        descriptionController.text.trim().isEmpty &&
        priceController.text.trim().isEmpty) {
      CherryToast.error(
          description: Text(
        "please fill all informations",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
      )).show(context);
      return;
    } else {
      ShopItemModel shopItemModel = ShopItemModel(
        createdAt: DateTime.now(),
        itemId: id,
        title: titleController.text,
        description: descriptionController.text,
        imageUrl: '',
        price: int.tryParse(priceController.text)!,
        discount: isDiscounted,
        likes: 0,
        priceAfterDiscount: int.tryParse(oldpriceController.text) ?? 0,
        views: 0,
        category: categorySelectedTile!,
      );
      await fireStore
          .collection("items_shop")
          .doc(id)
          .set(shopItemModel.toJson());
      CherryToast.success(
          description: Text(
        "product added successfully",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
      )).show(context);
    }
  }
}
