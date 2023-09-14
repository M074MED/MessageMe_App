import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String? id;
  String text;
  String sender;
  Timestamp time;

  MessageEntity(
      {this.id, required this.text, required this.sender, required this.time});
}
