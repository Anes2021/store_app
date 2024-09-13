class CategoryModel {
  final String itemId;
  final String title;
  final String? imageUrl;

  CategoryModel({
    required this.itemId,
    required this.title,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'title': title,
      'imageUrl': imageUrl,
    };
  }

  // JSON deserialization: Convert a Map into a CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      itemId: json['itemId'],
      title: json['title'],
      imageUrl: json['imageUrl'] ?? "",
    );
  }
}
