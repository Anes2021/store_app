import 'package:balagh/screens/home_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:balagh/src/services/shared_prefrences_service.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isItemLoading = true;
  late List<ShopItemModel> listOfItemsNEW;

  @override
  void initState() {
    initPage();
    super.initState();
  }

  initPage() async {
    // 1
    final prefrences = SharedPrefrencesController();

    listOfItemsNEW = [];
    List<String> favoritesList = await prefrences.readFavoritesList();
    // 2
    final firestore = FirebaseFirestore.instance;
    for (String id in favoritesList) {
      final datamodel =
          await firestore.collection("items_shop").doc(id).get().then((v) {
        return ShopItemModel.fromJson(v.data()!);
      });

      listOfItemsNEW.add(datamodel);
    }
    isItemLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            : Padding(
                padding: EdgeInsets.only(right: 10.w, left: 10.w),
                child: Wrap(
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
                ),
              );
  }
}
