class ShopItemModel {
  final DateTime createdAt;
  final String itemId;
  final String title;
  final String description;
  final String category;
  final String? imageUrl;
  final int price;
  final int priceAfterDiscount;
  final int views;
  final int likes;
  final bool discount;

  ShopItemModel({
    required this.category,
    required this.createdAt,
    required this.itemId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.priceAfterDiscount = 0,
    this.views = 0,
    this.likes = 0,
    this.discount = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'itemId': itemId,
      'category': category,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'views': views,
      'likes': likes,
      'discount': discount,
    };
  }

  // JSON deserialization: Convert a Map into a ShopItemModel
  factory ShopItemModel.fromJson(Map<String, dynamic> json) {
    return ShopItemModel(
      createdAt: DateTime.parse(json['createdAt']),
      itemId: json['itemId'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'] ?? "",
      price: json['price'],
      priceAfterDiscount: json['priceAfterDiscount'] ?? 0,
      views: json['views'] ?? 0,
      likes: json['likes'] ?? 0,
      discount: json['discount'] ?? false,
    );
  }
}
