import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messageme_app/src/viewModels/chat/message_view_model.dart';
import 'package:messageme_app/src/repositories/messages/firebase_messages.dart';


final messageNotifierProvider = ChangeNotifierProvider<MessageViewModel>((ref) {
  return MessageViewModel(ref: ref, messagesRepo: FirebaseMessages());
});
