class CategoryDetail {
  final bool status;
  final HighData? data;

  CategoryDetail({
    required this.status,
    required this.data,
  });
  factory CategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetail(
      status: json['status'],
      data: json['data'] != null ? HighData.fromJson(json['data']) : null,
    );
  }
}

//=======favourite Data Model======
class HighData {
  late final int currentPage;
  final List<CategoryProductItem> data = [];

  HighData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(CategoryProductItem.fromJson(element));
      });
    }
  }
}

//==========favourite product data mode=====
class CategoryProductItem {
  final int id;
  final num price;
  final num oldPrice;
  final num discount;
  final String image;
  final String name;
  final String description;
  final List<dynamic> images;
  final bool inFavourite;
  final bool inCart;

  CategoryProductItem({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavourite,
    required this.inCart,
  });
  factory CategoryProductItem.fromJson(Map<String, dynamic> json) {
    return CategoryProductItem(
      id: json['id'],
      price: json['price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? 'UnKnown',
      description: json['description'] ?? 'great Product',
      images: json['images'] ?? [],
      inFavourite: json['in_favorites'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}
