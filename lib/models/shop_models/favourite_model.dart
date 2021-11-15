class FavouriteModel {
  final bool status;
  final HighData? data;

  FavouriteModel({
    required this.status,
    required this.data,
  });
  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      status: json['status'],
      data: json['data'] != null ? HighData.fromJson(json['data']) : null,
    );
  }
}

//=======favourite Data Model======
class HighData {
 late final int currentPage ;
final  List<DataModel> data = [];

  HighData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(DataModel.fromJson(element));
      });
    }
  }
}

//=======favourite Data Model======
class DataModel {
  late final int id;
  final FavouriteProductData? favouriteProductData;

  DataModel({
    required this.id,
    required this.favouriteProductData,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      favouriteProductData: json['product'] != null
          ? FavouriteProductData.fromJson(json['product'])
          : null,
    );
  }
}

//==========favourite product data mode=====
class FavouriteProductData {
  int id = 0;
  num price = 0;
  num oldPrice = 0;
  num discount = 0;
  String image = '';
  String name = '';
  String description = '';

  FavouriteProductData({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
  factory FavouriteProductData.fromJson(Map<String, dynamic> json) {
    return FavouriteProductData(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
