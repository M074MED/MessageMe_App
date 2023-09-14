import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messageme_app/src/viewModels/chat/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {String? id,
      required String text,
      required String sender,
      required Timestamp time})
      : super(id: id, text: text, sender: sender, time: time);

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
      id: json["id"],
      text: json["text"],
      sender: json["sender"],
      time: json["time"]);

  Map<String, dynamic> toJson() => {
        "text": text,
        "sender": sender,
        "time": time,
      };
}
