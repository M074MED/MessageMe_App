import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messageme_app/src/models/message_model.dart';
import 'package:messageme_app/src/repositories/messages/messages_repo.dart';

import 'message_entity.dart';

class MessageViewModel extends ChangeNotifier {
  Ref ref;
  final MessagesRepo _messagesRepo;
  Stream<QuerySnapshot<Map<String, dynamic>>>? messagesSnapshots;
  bool isLoading = false;
  bool isSending = false;

  MessageViewModel({required this.ref, required MessagesRepo messagesRepo})
      : _messagesRepo = messagesRepo;

  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllMessages() {
    messagesSnapshots = _messagesRepo.getAllMessages();
    return messagesSnapshots;
  }

  Future<void> deleteMessage(String id) async {
    isLoading = true;
    notifyListeners();
    await _messagesRepo.deleteMessage(id);
    isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(MessageEntity message) async {
    isSending = true;
    notifyListeners();
    final messageModel = MessageModel(
        id: message.id,
        text: message.text,
        sender: message.sender,
        time: message.time);

    await _messagesRepo.sendMessage(messageModel);
    isSending = false;
    notifyListeners();
  }
}
