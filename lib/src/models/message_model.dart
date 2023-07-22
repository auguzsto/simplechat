class MessageModel {
  String? uuid;
  String? message;
  String type;

  MessageModel({
    this.uuid,
    this.message,
    this.type = "sent",
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      uuid: map['uuid'],
      message: map['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "message": message,
    };
  }
}
