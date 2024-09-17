import 'package:balagh/screens/home_screen.dart';
import 'package:balagh/screens/item_shop_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/category_model.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late List<ShopItemModel> listOfItemsNEW = [];
  bool isItemLoading = true;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    setState(() {
      isItemLoading = true;
    });
    listOfItemsNEW = await firestore
        .collection("items_shop")
        .where('category', isEqualTo: widget.categoryModel.title)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return ShopItemModel.fromJson(doc.data());
      }).toList();
    });
    setState(() {
      isItemLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBar(),
            Gap(20.h),
            items(),
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                Gap(20.w),
                Text(
                  widget.categoryModel.title,
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

  Widget newProductsItem(String title, String description, int price,
      bool discount, int beforePrice, bool isNew, ShopItemModel itemModel) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ItemShopScreen(
                itemModel: itemModel,
              ),
            ));
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 20.w - 10.w) / 2,
            height: 310.h,
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
                              ?.copyWith(
                                  color: AppColors.backgroundColorGrey02),
                        ),
                        Gap(3.h),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: AppColors.backgroundColorGrey01),
                        ),
                        Gap(5.h),
                        discount
                            ? Text(
                                "$price£",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                          children: [
                            Expanded(
                              child: Text(
                                "$price£",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: AppColors.backgroundColorGrey02),
                              ),
                            ),
                            Text(
                              '(4.5)',
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

  Widget items() {
    return (isItemLoading)
        ? const CircularProgressIndicator(color: Colors.orange)
        : (listOfItemsNEW.isEmpty)
            ? Text(
                "This List is Empty",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.backgroundColorGrey01),
              )
            : Wrap(
                spacing: 5.0, // Horizontal spacing between items
                runSpacing: 7.0, // Vertical spacing between rows
                children: List.generate(listOfItemsNEW.length, (index) {
                  final item = listOfItemsNEW[index];

                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 30) /
                        2, // 2 columns
                    child: NewProductItem(
                      title: item.title,
                      description: item.description,
                      price: item.priceAfterDiscount,
                      discount: item.discount,
                      beforePrice: item.price,
                      itemModel: item,
                    ),
                  );
                }),
              );
  }
}
