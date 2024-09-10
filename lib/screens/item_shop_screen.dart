import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ItemShopScreen extends StatefulWidget {
  const ItemShopScreen({super.key, required this.itemModel});

  final ShopItemModel itemModel;
  @override
  State<ItemShopScreen> createState() => _ItemShopScreenState();
}

class _ItemShopScreenState extends State<ItemShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Gap(60.h),
              imagesPreview(),
              Gap(10.h),
              productInfo(),
              Gap(10.h),
              reviewZone(),
              Gap(100.h),
            ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appBar(),
              bottomBar(),
            ],
          ),
        ],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 30.sp,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                Gap(10.w),
                Text(
                  "Product Details",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 20),
                ),
                Gap(10.w),
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
                    child: Center(
                      child: Icon(
                        Icons.menu_rounded,
                        size: 30.sp,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      width: double.infinity.w,
      decoration: BoxDecoration(
        color: AppColors.backgroundColorOne,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            spreadRadius: 5, // How much the shadow spreads
            blurRadius: 30, // Softens the shadow
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.orange,
                          width: 2.sp,
                        ),
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppColors.backgroundColorOne,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.orange,
                              size: 30,
                            ),
                            Gap(15.w),
                            Text(
                              "Add to Cart",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(10.w),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.orange,
                        width: 2.sp,
                      ),
                      borderRadius: BorderRadius.circular(10.sp),
                      color: AppColors.backgroundColorOne,
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_sharp,
                            color: Colors.orange,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(10.w),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewZone() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            color: AppColors.backgroundColorGrey01,
            height: 1.h,
            width: double.infinity,
          ),
        ),
        Gap(10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Reviews :",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.backgroundColorGrey01,
                          fontSize: 15,
                        ),
                  ),
                ],
              ),
              const ItemShopComments(),
              const ItemShopComments(),
              const ItemShopComments(),
              const ItemShopComments(),
            ],
          ),
        )
      ],
    );
  }

  Widget imagesPreview() {
    return Container(
      width: double.infinity.w,
      height: 250.h,
      color: AppColors.backgroundColorGrey02,
    );
  }

  Widget productInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.itemModel.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 22),
            ),
            Gap(10.h),
            Row(
              children: [
                Text(
                  widget.itemModel.priceAfterDiscount.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.itemModel.price.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.backgroundColorGrey02,
                        fontSize: 40,
                      ),
                ),
                Text(
                  "\$",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.backgroundColorGrey02,
                        fontSize: 40,
                      ),
                ),
              ],
            ),
            Gap(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                color: AppColors.backgroundColorGrey01,
                height: 1.h,
                width: double.infinity,
              ),
            ),
            Gap(10.h),
            Text(
              "Description :",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.backgroundColorGrey01,
                    fontSize: 15,
                  ),
            ),
            Text(
              widget.itemModel.description,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.backgroundColorGrey02,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
