// ignore_for_file: unused_element

import 'package:balagh/screens/admin/create_item_shop_screen.dart';
import 'package:balagh/screens/cart_screen.dart';
import 'package:balagh/screens/categories_screen.dart';
import 'package:balagh/screens/item_shop_screen.dart';
import 'package:balagh/screens/orders_screen.dart';
import 'package:balagh/screens/profile_screen.dart';
import 'package:balagh/src/core/app_color.dart';
import 'package:balagh/src/models/shop_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart'; // Import persistent_bottom_nav_bar

import '../src/presentation/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late List<ShopItemModel> listOfItemsNEW = [];
  bool isItemLoading = true;

  // PersistentTabController for controlling the bottom navigation bar
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // Add CartScreen and OrdersScreen to the list of screens
  final List<Widget> screens = [
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() async {
    setState(() {
      isItemLoading = true;
    });
    listOfItemsNEW =
        await firestore.collection("items_shop").get().then((snapshot) {
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
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        navBarHeight: 60,
        backgroundColor:
            AppColors.backgroundColorTwo, // Nav bar background color
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: AppColors.backgroundColorOne,
        ),
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        navBarStyle: NavBarStyle.style3, // Choose nav bar style
      ),
    );
  }

  // Build the screens for the bottom navigation bar
  List<Widget> _buildScreens() {
    return [
      _buildHomeScreenContent(), // Home screen content
      const OrdersScreen(),
      const CartScreen(),
      const CategoriesScreen(),
      const ProfileScreen(),
    ];
  }

  // Build the bottom navigation items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.moneyCheckDollar),
        title: ("Orders"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          FontAwesomeIcons.basketShopping,
          size: 23,
        ),
        title: ("Cart"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.grip),
        title: ("Categores"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_rounded),
        title: ("Profile"),
        activeColorPrimary: Colors.orange,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  // Move the original content of HomeScreen to a separate method
  Widget _buildHomeScreenContent() {
    return Container(
      color:
          AppColors.backgroundColorOne, // Explicitly set background color here
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gap(40.h),
            _buildAppBar(),
            _buildSearchBar(),
            _buildCategoryList(),
            _buildNewProducts(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const CreateItemShopScreen()),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.backgroundColorGrey01,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.backgroundColorOne,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Atchi_L8r3",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "id: xxxx,xxxx,xxxx,xxxx",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.backgroundColorGrey01,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.backgroundColorGrey03,
            ),
            child: const Center(
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.backgroundColorGrey01,
                size: 25,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.backgroundColorGrey01,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.backgroundColorGrey03,
            ),
            child: const Center(
              child: Icon(
                Icons.notifications_outlined,
                color: AppColors.backgroundColorGrey01,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          TextFieldSearchModel(
            controller: searchController,
            hintText: "Find What's you Need",
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.location_on_sharp,
                color: Colors.orange,
                size: 15,
              ),
              Expanded(
                child: Text(
                  "Location Location Location Location Location Location Location",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.memory, 'label': 'Storage'},
      {'icon': Icons.dns, 'label': 'Servers'},
      {'icon': Icons.desktop_mac, 'label': 'Monitors'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
    ];

    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 30, top: 10),
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 70,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.backgroundColorGrey01, width: 1.5),
                  color: AppColors.backgroundColorGrey03,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget newProductsItem(String title, String description, int price,
      bool discount, int beforePrice, ShopItemModel itemModel) {
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: itemModel.imageUrl != null &&
                            itemModel.imageUrl!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: itemModel.imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                          )
                        : Center(
                            child: Text('No image available',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium)), // Display this when URL is null or empty
                  ),
                ),
                Gap(5.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewProducts() {
    return Padding(
      padding: EdgeInsets.only(right: 10.w, left: 10.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.radio_button_checked_outlined,
                color: Colors.orange,
                size: 20.sp,
              ),
              Gap(5.w),
              Text("What's new!",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  child: Container(
                    height: 1.h,
                    color: AppColors.backgroundColorGrey03,
                  ),
                ),
              ),
              Text("See all",
                  style: TextStyle(color: Colors.orange, fontSize: 13.sp)),
            ],
          ),
          Gap(10.h),
          (isItemLoading)
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
                    ),
          Gap(20.h),
        ],
      ),
    );
  }
}

class NewProductItem extends StatelessWidget {
  final String title;
  final String description;
  final int price;
  final bool discount;
  final int beforePrice;
  final ShopItemModel itemModel;

  const NewProductItem({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.beforePrice,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToItemShopScreen(context, itemModel),
      child: Container(
        width: (MediaQuery.of(context).size.width - 30.w) / 2,
        decoration: _itemDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _productImage(context),
            _productDetails(context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _itemDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.backgroundColorGrey01, width: 1),
      color: AppColors.backgroundColorGrey03,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _productImage(BuildContext context) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: itemModel.imageUrl != null && itemModel.imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: itemModel.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, color: Colors.red)),
              )
            : Center(
                child: Text('No image available',
                    style: Theme.of(context).textTheme.bodyMedium)),
      ),
    );
  }

  Widget _productDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
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
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.backgroundColorGrey02, fontSize: 18),
            ),
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.backgroundColorGrey01),
            ),
            const Expanded(
                child: SizedBox(
              width: 0,
            )),
            discount
                ? Text(
                    "$beforePrice£",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                        ?.copyWith(color: AppColors.backgroundColorGrey02),
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
                      border: Border.all(color: Colors.orange, width: 1.5),
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
    );
  }

  Widget _priceDetails(BuildContext context) {
    return Text(
      discount ? "$price£" : "$beforePrice£",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: discount ? Colors.red[800] : AppColors.backgroundColorGrey02,
            fontSize: 13.sp,
            decoration: discount ? TextDecoration.lineThrough : null,
            decorationColor: Colors.red[800],
            decorationThickness: 1.0,
          ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Row(
      children: [
        _shoppingCartButton(),
        Gap(5.w),
        _favoriteButton(),
      ],
    );
  }

  Widget _shoppingCartButton() {
    return Expanded(
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.orange, width: 1.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Icon(
            Icons.add_shopping_cart_rounded,
            size: 25.sp,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }

  Widget _favoriteButton() {
    return Expanded(
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Icon(
            Icons.favorite_rounded,
            size: 25.sp,
            color: AppColors.backgroundColorGrey03,
          ),
        ),
      ),
    );
  }

  void _navigateToItemShopScreen(
      BuildContext context, ShopItemModel itemModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemShopScreen(itemModel: itemModel),
      ),
    );
  }
}
