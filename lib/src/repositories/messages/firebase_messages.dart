import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messageme_app/src/models/message_model.dart';
import 'package:messageme_app/src/repositories/messages/messages_repo.dart';
import 'package:messageme_app/utils/toast_message.dart';

class FirebaseMessages extends MessagesRepo {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteMessage(String id) async {
    try {
      await firestore.collection("Messages").doc(id).delete();
    } catch (e) {
      ToastMessage(message: e.toString(), bgColor: Colors.red).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllMessages() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? messagesSnapshots;
    try {
      messagesSnapshots =
          firestore.collection("Messages").orderBy("time").snapshots();
    } catch (e) {
      ToastMessage(message: e.toString(), bgColor: Colors.red).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
    return messagesSnapshots;
  }

  @override
  Future<void> sendMessage(MessageModel message) async {
    try {
      await firestore.collection("Messages").add(message.toJson());
    } catch (e) {
      ToastMessage(message: e.toString(), bgColor: Colors.red).show();
      print("-------------------------------------------------------------");
      print(e);
      print("-------------------------------------------------------------");
    }
  }
}
