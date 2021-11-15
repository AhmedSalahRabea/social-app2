class SocialUserModel {
  final String name;
  final String? email;
  final String phone;
  final String? uId;
  final String? image;
  final String? coverImage;

  final String bio;
  final bool isEmailVerified;

  SocialUserModel({
    required this.name,
    this.email,
    required this.phone,
    this.uId,
    this.image,
    this.coverImage,
    required this.bio,
    required this.isEmailVerified,
  });
  factory SocialUserModel.fromJson(Map<String, dynamic>? json) {
    return SocialUserModel(
      name: json!['name'],
      email: json['email'],
      phone: json['phone'],
      uId: json['uId'],
      image: json['image'],
      coverImage: json['coverImage'],
      bio: json['bio'],
      isEmailVerified: json['isEmailVerified'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'coverImage': coverImage,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
