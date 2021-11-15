class MessageModel {
  final String? senderId;
  final String? recieverId;
  final String? dateTime;
  final String? text;

  MessageModel({
    this.senderId,
    this.recieverId,
    this.dateTime,
    this.text,
  });
  factory MessageModel.fromJson(Map<String, dynamic>? json) {
    return MessageModel(
      senderId: json!['senderId'],
      recieverId: json['recieverId'],
      dateTime: json['dateTime'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
