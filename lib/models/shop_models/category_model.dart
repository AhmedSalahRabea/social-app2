class CategoryModel {
  final bool status;
  final CategoryDataModel data;

  CategoryModel({
    required this.status,
    required this.data,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      status: json['status'],
      data: CategoryDataModel.fromJson(json['data']),
    );
  }
}

class CategoryDataModel {
  late int currentPage;
  List<DataModel> data = [];
  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

//========Data Model for one category====
class DataModel {
  final int id;
  final String name;
  final String image;

  DataModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
