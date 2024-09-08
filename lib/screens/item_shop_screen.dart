import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
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
      body: SingleChildScrollView(
        child: Column(children: [
          Gap(40.h),
          appBar(),
          Gap(20.h),
          imagesPreview(),
          Gap(10.h),
          productInfo(),
        ]),
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
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
            style: Theme.of(context).textTheme.bodyLarge,
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
            Text(
              widget.itemModel.priceAfterDiscount.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              widget.itemModel.price.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.backgroundColorGrey02,
                    fontSize: 36,
                  ),
            ),
            Gap(10.h),
            Text(
              "Description :",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.backgroundColorGrey01,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            Gap(10.h),
            Text(
              widget.itemModel.description,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.backgroundColorGrey02, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
