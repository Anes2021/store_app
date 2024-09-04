import 'package:balagh/src/core/app_color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            _buildAppBar(),
            _buildSearchBar(),
            // _buildCategoryList(),
            // const SizedBox(height: 10),
            _buildFlashSale(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
    return Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.backgroundColorGrey01, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.backgroundColorOne),
            ),
            const SizedBox(width: 5),
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
            )
          ],
        ));
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Find what you need',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.memory, 'label': 'Storage'},
      {'icon': Icons.dns, 'label': 'Servers'},
      {'icon': Icons.desktop_mac, 'label': 'Monitors'},
      {'icon': Icons.devices_other, 'label': 'Accessories'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 30,
                    child: Icon(categories[index]['icon'], color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Text(categories[index]['label'],
                      style: const TextStyle(color: Colors.black)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFlashSale() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Flash Sale",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("See all", style: TextStyle(color: Colors.orange)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFlashSaleItem(
                  // 'assets/laptop1.png',
                  'LapTop Lenovo Ryzen 5',
                  'A laptop is a portable computer...',
                ),
                _buildFlashSaleItem(
                  // 'assets/laptop2.png',
                  'LapTop Microsoft Surface',
                  'A laptop is a portable computer...',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSaleItem(
      // String imagePath,
      String title,
      String description) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                // image: DecorationImage(
                //   image: AssetImage(imagePath),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
