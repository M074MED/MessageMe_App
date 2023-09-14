import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/message_model.dart';

abstract class MessagesRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllMessages();
  Future<void> deleteMessage(String id);
  Future<void> sendMessage(MessageModel message);
}
