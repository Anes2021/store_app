// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/category_model.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
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
  List<CategoryModel> categoryTiles = [];
  String? priceSelectedTile;
  String? categorySelectedTile;
  bool isDiscounted = false;
  double? discountPercantage;
  final bool _uploading = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery); // Pick image
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile; // Assign XFile to _image
      });
    }
  }

  @override
  void initState() {
    priceSelectedTile = priceTiles[0];

    initPage();
    super.initState();
  }

  void initPage() async {
    QuerySnapshot snapshot = await firestore.collection("categories").get();

    // Map Firestore documents to CategoryModel and store them in categoryTiles
    categoryTiles = snapshot.docs.map((doc) {
      return CategoryModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    // If categories are fetched, initialize categorySelectedTile
    if (categoryTiles.isNotEmpty) {
      setState(() {
        categorySelectedTile =
            categoryTiles[0].title.toString(); // Use the first category's ID
      });
    }
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
                          color: AppColors.backgroundColorGrey01, width: 2),
                    ),
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
                child: (_image == null)
                    ? const Center(
                        child: Text("no image"),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_image!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Gap(5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
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
                    if (discount)
                      Text(
                        "$price\$",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.red[800],
                              fontSize: 13.sp,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red[800],
                              decorationThickness: 1.0,
                            ),
                      )
                    else
                      Gap(17.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            discount ? "$afterPrice\$" : "$price\$",
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
                          ),
                        ),
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
                          ),
                        ),
                      ],
                    ),
                    Gap(6.h)
                  ],
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
          ),
        ),
        Gap(10.w),
        Text(
          "Create Item in Shop",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget imagePickUpContainer() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _pickImage();
          },
          child: Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  border: Border.all(
                      color: AppColors.backgroundColorGrey01, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              child: (_image == null)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 40.sp,
                          color: AppColors.backgroundColorGrey02,
                        ),
                        Text(
                          "Add Photo to The Category.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: AppColors.backgroundColorGrey02,
                                  fontSize: 16),
                        )
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ))),
        ),
        (_image != null)
            ? GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((_image == null) ? "" : "Click to change Image")
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget textFields() {
    return Column(
      children: [
        CustomTextField(
          controller: titleController,
          hintText: "put title here",
          function: (String text) {
            setState(() {
              titleController;
            });
          },
        ),
        Gap(10.h),
        CustomTextField(
          maxLines: 3,
          minLines: 3,
          textFieldHeight: 15,
          controller: descriptionController,
          hintText: "put description here",
          function: (String text) {
            setState(() {
              descriptionController;
            });
          },
        ),
      ],
    );
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
              ),
            ),
          ],
        ),
        Gap(10.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                hintText: (isDiscounted == false) ? "Add Price" : "Old Price",
                enabled: (isDiscounted == true) ? false : true,
                function: (String text) {
                  setState(() {
                    priceController;
                  });
                },
              ),
            ),
            Gap(10.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColorGrey03,
                  border: Border.all(
                    color: AppColors.backgroundColorGrey01,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "discount:",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      SizedBox(
                        child: DropdownButton<String>(
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
                                  ),
                                ).show(context);
                                priceSelectedTile == priceTiles[0];
                                isDiscounted = false;
                                return;
                              } else if (int.tryParse(
                                    priceController.text,
                                  )! <
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
                                  ),
                                ).show(context);
                                priceSelectedTile == priceTiles[0];
                                isDiscounted = false;
                                return;
                              } else {
                                priceSelectedTile = newValue;
                                isDiscounted =
                                    priceSelectedTile != priceTiles[0];
                              }

                              log(isDiscounted.toString());
                            });
                          },
                          underline: Container(),
                          iconSize: 0,
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
                    child: CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: oldpriceController,
                      hintText: "Price After Discounting",
                      function: (String newPrice) {
                        int price = int.tryParse(priceController.text) ?? 0;
                        int? newPriceVal =
                            int.tryParse(oldpriceController.text);
                        if (newPriceVal != null &&
                            (newPriceVal > price || newPriceVal < 0)) {
                          CherryToast.error(
                            description: Text(
                              "new price needs to be smaller than $price and greater than 0",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColors.backgroundColorGrey03),
                            ),
                          ).show(context);
                        } else {
                          discountPercantage =
                              (((price - (newPriceVal ?? 0)) / price) * 100)
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
                      child: CustomTextField(
                        function: (newPrice) {
                          setState(() {
                            discountPercantage;
                            newPrice;
                          });
                        },
                        enabled: false,
                        controller: TextEditingController(),
                        hintText: "$discountPercantage",
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
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
              ),
            ),
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
                    color: AppColors.backgroundColorGrey01,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categoryTiles.isNotEmpty
                            ? "Category"
                            : "There isn't Categories, Create some.",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppColors.backgroundColorGrey01),
                      ),
                      Expanded(
                        child: ListTile(
                          minTileHeight: 49,
                          trailing: DropdownButton<CategoryModel>(
                            value: categoryTiles.isNotEmpty
                                ? categoryTiles.firstWhere(
                                    (element) =>
                                        element.itemId == categorySelectedTile,
                                    orElse: () => categoryTiles[0])
                                : null, // Handle case when categoryTiles is empty
                            items: categoryTiles.isNotEmpty
                                ? categoryTiles
                                    .map<DropdownMenuItem<CategoryModel>>(
                                        (CategoryModel value) {
                                    return DropdownMenuItem<CategoryModel>(
                                      value: value,
                                      child: Text(
                                        value.title, // Display category name
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(color: Colors.orange),
                                      ),
                                    );
                                  }).toList()
                                : [], // Provide an empty list if categoryTiles is empty
                            onChanged: categoryTiles.isNotEmpty
                                ? (CategoryModel? newValue) {
                                    setState(() {
                                      categorySelectedTile = newValue
                                          ?.itemId; // Store the selected category's ID
                                    });
                                    CherryToast.info(
                                      description: Text(
                                        "Product category changed to ${newValue?.title}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 13.sp,
                                                color: AppColors
                                                    .backgroundColorGrey03),
                                      ),
                                    ).show(context);
                                  }
                                : null, // Disable dropdown if there are no categories
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
              ),
            ),
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
                  color: AppColors.backgroundColorGrey01,
                  width: 1.5.sp,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: newProductsItem(
                      (titleController.text.trim().isEmpty)
                          ? "Product Title Here"
                          : (titleController.text),
                      (descriptionController.text.trim().isEmpty)
                          ? "Product Description Here"
                          : (descriptionController.text),
                      int.tryParse(priceController.text) ?? 0,
                      isDiscounted,
                      int.tryParse(oldpriceController.text) ?? 0,
                      true,
                    ),
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
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: AppColors.backgroundColorGrey03,
            ),
      ),
    ).show(context);
  }

  Future<String> uploadImageFile(XFile imageFile) async {
    String fileName =
        "images/${const Uuid().v4()}.jpg"; // Ensuring a unique file name
    File file = File(imageFile.path);

    try {
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      firebase_storage.UploadTask uploadTask = ref.putFile(file);
      firebase_storage.TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl; // This URL can be stored in Firestore
    } catch (e) {
      print(e);
      return ''; // Handle errors appropriately
    }
  }

  Future<void> createItemShop() async {
    // Validate input fields
    if (titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        int.tryParse(priceController.text) == null ||
        categorySelectedTile == null ||
        _image == null) {
      CherryToast.error(
        description: Text(
          "Please fill all information and select an image",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp, color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
      return;
    }

    // Upload image and get URL
    String imageUrl = await uploadImageFile(_image!);
    if (imageUrl.isEmpty) {
      CherryToast.error(
        description: Text(
          "Failed to upload image",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 13.sp,
                color: AppColors.backgroundColorGrey03,
              ),
        ),
      ).show(context);
      return; // Exit if the image fails to upload
    }
    log(categorySelectedTile!);
    // Continue with creating the item if the image upload was successful
    ShopItemModel shopItemModel = ShopItemModel(
      createdAt: DateTime.now(),
      itemId: const Uuid().v4(),
      title: titleController.text,
      description: descriptionController.text,
      imageUrl: imageUrl, // Store the URL from Firebase Storage
      price: int.tryParse(priceController.text) ?? 0,
      discount: isDiscounted,
      likes: 0,
      priceAfterDiscount: int.tryParse(oldpriceController.text) ?? 0,
      views: 0,
      category: categorySelectedTile
          .toString(), // Assuming this returns the correct string representation for category
    );

    // Save the item data to Firestore
    await FirebaseFirestore.instance
        .collection("items_shop")
        .doc(shopItemModel.itemId)
        .set(shopItemModel.toJson());

    // Show success message and navigate back
    CherryToast.success(
      description: Text(
        "Product added successfully",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
              color: AppColors.backgroundColorGrey03,
            ),
      ),
    ).show(context);
    Navigator.of(context).pop(); // Optionally navigate back or clear fields
  }
}
