// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/presentation/widgets.dart';
import 'package:balagh/src/services/shared_prefrences_service.dart';
import 'package:cherry_toast/cherry_toast.dart';
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
                addToCartButton(
                  id: widget.itemModel.itemId,
                ),
                Gap(10.w),
                LikeButton(
                  id: widget.itemModel.itemId,
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
              Gap(10.h),
              const Wrap(
                runSpacing: 10,
                children: [
                  ItemShopComments(),
                  ItemShopComments(),
                  ItemShopComments(),
                  ItemShopComments(),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget imagesPreview() {
    return SizedBox(
      width: double.infinity.w,
      child: Image.network(
        widget.itemModel.imageUrl.toString(),
        fit: BoxFit.fitWidth,
      ),
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
                (widget.itemModel.discount)
                    ? Text(
                        widget.itemModel.priceAfterDiscount.toString(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )
                    : Container(),
                (widget.itemModel.discount)
                    ? Text(
                        "\$",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )
                    : Container(),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.itemModel.price.toString(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.backgroundColorGrey01,
                        fontSize: 40,
                      ),
                ),
                Text(
                  "\$",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.backgroundColorGrey01,
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

class addToCartButton extends StatefulWidget {
  const addToCartButton({
    super.key,
    required this.id,
  });
  final String id;
  @override
  State<addToCartButton> createState() => _addToCartButtonState();
}

class _addToCartButtonState extends State<addToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          log(widget.id);
          CherryToast.success(
            description: Text(
              "Item added to cart (go to the cart screen to modify the quantity).",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.backgroundColorGrey03),
            ),
          ).show(context);
        },
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
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = true;
  final prefrences = SharedPrefrencesController();
  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    List favoritesList = await prefrences.readFavoritesList();
    log(favoritesList.toString());
    isLiked = favoritesList.contains(widget.id);
    setState(() {});
  }

  void clickedLike() async {
    List<String> favoritesList = await prefrences.readFavoritesList();
    if (isLiked) {
      favoritesList.remove(widget.id);
      await prefrences.writeFavorites(favoritesList);
      setState(() {
        isLiked = !isLiked;
      });
      CherryToast.success(
        description: Text(
          "Item removed from Favorites Screen",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
    } else {
      favoritesList.add(widget.id);
      await prefrences.writeFavorites(favoritesList);
      setState(() {
        isLiked = !isLiked;
      });
      CherryToast.success(
        description: Text(
          "Item added to Favorites Screen",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.backgroundColorGrey03),
        ),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log(isLiked.toString());
        clickedLike();
      },
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border_sharp,
                color: Colors.orange,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class bottomSheet extends StatelessWidget {
  const bottomSheet({super.key});

  void _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.navigation, color: Colors.blue),
                title: Text('Navigation'),
              ),
              ListTile(
                leading: Icon(Icons.map, color: Colors.blue),
                title: Text('Maps'),
              ),
              ListTile(
                leading: Icon(Icons.directions_car, color: Colors.blue),
                title: Text('Altitude'),
              ),
              ListTile(
                leading: Icon(Icons.local_post_office, color: Colors.blue),
                title: Text('Pincode'),
              ),
              ListTile(
                leading: Icon(Icons.history, color: Colors.blue),
                title: Text('Past Details'),
              ),
            ],
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
