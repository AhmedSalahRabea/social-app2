class SearchModel {
  final bool status;
  final HighData? data;

  SearchModel({
    required this.status,
    required this.data,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      data: json['data'] != null ? HighData.fromJson(json['data']) : null,
    );
  }
}

//=======favourite Data Model======
class HighData {
  late final int currentPage;
  final List<SearchedProductData> data = [];

  HighData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(SearchedProductData.fromJson(element));
      });
    }
  }
}

//==========favourite product data mode=====
class SearchedProductData {
  final int id;
  final num price;
  final String image;
  final String name;
  final String description;
  final List<dynamic> images;
  final bool inFavourite;
  final bool inCart;

  SearchedProductData({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavourite,
    required this.inCart,
  });
  factory SearchedProductData.fromJson(Map<String, dynamic> json) {
    return SearchedProductData(
      id: json['id'],
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? 'UnKnown',
      description: json['description'] ?? 'great Product',
      images: json['images'] ?? [],
      inFavourite: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}
