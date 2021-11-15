class SocialPostModel {
  final String? name;
  final String? uId;
  final String? dateTime;
  final String? text;
  final String? image;
  final String? postImage;

  SocialPostModel({
    this.name,
    this.uId,
    this.dateTime,
    this.text,
    this.image,
    this.postImage
  });
  factory SocialPostModel.fromJson(Map<String, dynamic>? json) {
    return SocialPostModel(
      name: json!['name'],
      uId: json['uId'],
      dateTime: json['dateTime'],
      text: json['text'],
      image: json['image'],
      postImage: json['postImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'text': text,
      'image': image,
      'postImage':postImage,
    };
  }
}
