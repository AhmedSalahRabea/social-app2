class ChangeFavouritesModel {
  final bool status;
  final String message;

  ChangeFavouritesModel({
    required this.status,
    required this.message,
  });
  factory ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    return ChangeFavouritesModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
