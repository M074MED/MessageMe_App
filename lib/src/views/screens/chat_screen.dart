import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messageme_app/src/viewModels/chat/message_entity.dart';
import 'package:messageme_app/src/providers/message_provider.dart';
import 'package:messageme_app/src/views/screens/welcome_screen.dart';
import 'package:messageme_app/src/views/theme/app_colors.dart';
import 'package:messageme_app/src/views/widgets/logo_image_widget.dart';
import 'package:messageme_app/src/views/widgets/text_button_widget.dart';
import 'package:messageme_app/utils/constants.dart';
import 'package:messageme_app/utils/toast_message.dart';

import '../../models/message_model.dart';
import '../../providers/user_provider.dart';
import 'package:rect_getter/rect_getter.dart';

import '../../viewModels/chat/message_view_model.dart';

class ChatScreen extends ConsumerWidget {
  static const String screenRoute = '/chat_screen';

  final TextEditingController messageInputController = TextEditingController();

  final Map<String, GlobalKey<RectGetterState>> _messageWidgetKey = {};

  ChatScreen({Key? key}) : super(key: key);

  GlobalKey getGlobalKey(String debugLabel) {
    final key = RectGetter.createGlobalKey();
    _messageWidgetKey[debugLabel] = key;
    return key;
  }

  void _showMessageOptionsPopupMenu(BuildContext context, String messageText,
      String id, MessageViewModel messagesViewModelNotifierProvider) async {
    Rect? rect = RectGetter.getRectFromKey(_messageWidgetKey[id]!);

    // Getting values of all four coordinate left, top, right and
    // bottom using Rect instance
    var left = rect!.left;
    var top = rect.top;
    var right = rect.right;
    var bottom = rect.bottom;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, right, bottom),
      items: [
        PopupMenuItem<String>(
          value: messageText,
          child: const Text('Copy'),
          onTap: () {
            Clipboard.setData(ClipboardData(text: messageText));
            const ToastMessage(message: "Copied", bgColor: Colors.green).show();
          },
        ),
        PopupMenuItem<String>(
          value: id,
          child: const Text('Delete'),
          onTap: () {
            _showDeleteDialog(context, id, messagesViewModelNotifierProvider);
          },
        ),
      ],
      elevation: 8.0,
    );
  }

  _showDeleteDialog(BuildContext context, String id,
      MessageViewModel messagesViewModelNotifierProvider) {
    showDialog(
      context: context,
      builder: (context) => messagesViewModelNotifierProvider.isLoading
          ? const CircularProgressIndicator()
          : AlertDialog(
              title:
                  const Text("Are you sure you want to delete this message?"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    messagesViewModelNotifierProvider.deleteMessage(id);
                    Navigator.pop(context);
                    const ToastMessage(
                            message: "Deleted", bgColor: Colors.green)
                        .show();
                  },
                  child: const Text("Yes"),
                )
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch<UserProviderApi>(userProvider);
    final messagesViewModelNotifierProvider =
        ref.watch(messageNotifierProvider);
    return Scaffold(
      appBar: _buildAppBar(context, user),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: StreamBuilder(
                stream: messagesViewModelNotifierProvider.getAllMessages(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData ||
                      messagesViewModelNotifierProvider.getAllMessages() ==
                          null) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2 - 50),
                        child: const Text(
                          "No Messages Available",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }
                  final List<MessageEntity> allMessages = [];
                  for (var doc in snapshot.data!.docs.reversed) {
                    final message = MessageModel(
                        id: doc.id,
                        text: doc.data()["text"],
                        sender: doc.data()["sender"],
                        time: doc.data()["time"]);
                    allMessages.add(message);
                  }

                  return Expanded(
                    child: ListView.builder(
                        itemCount: allMessages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final bool isMyMessage =
                              user.email == allMessages[index].sender;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: isMyMessage
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allMessages[index].sender,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primaryColor),
                                ),
                                InkWell(
                                  onLongPress: () {
                                    _showMessageOptionsPopupMenu(
                                        context,
                                        allMessages[index].text,
                                        allMessages[index].id!,
                                        messagesViewModelNotifierProvider);
                                  },
                                  child: Material(
                                    key: getGlobalKey(allMessages[index].id!),
                                    elevation: 5,
                                    borderRadius: BorderRadius.only(
                                      topLeft: isMyMessage
                                          ? const Radius.circular(30)
                                          : Radius.zero,
                                      topRight: isMyMessage
                                          ? Radius.zero
                                          : const Radius.circular(30),
                                      bottomLeft: const Radius.circular(30),
                                      bottomRight: const Radius.circular(30),
                                    ),
                                    color: isMyMessage
                                        ? AppColors.secondaryColor
                                        : Colors.grey[200],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        allMessages[index].text,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: isMyMessage
                                              ? Colors.white
                                              : Colors.black45,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageInputController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: "Type Your Message...",
                        border: InputBorder.none,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: AppColors.secondaryColor,
                          width: 3,
                        )),
                      ),
                    ),
                  ),
                  messagesViewModelNotifierProvider.isSending
                      ? const CircularProgressIndicator()
                      : TextButtonWidget(
                          onPressed: () {
                            if (messageInputController.text.trim() == '') {
                              return;
                            }
                            final message = MessageEntity(
                              text: messageInputController.text,
                              sender: user.email,
                              time: Timestamp.now(),
                            );
                            messagesViewModelNotifierProvider
                                .sendMessage(message);
                            messageInputController.text = '';
                          },
                          fgColor: AppColors.secondaryColor,
                          child: const Text(
                            "Send",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, UserProviderApi user) => AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              LogoImageWidget(height: 40),
              SizedBox(
                width: 10,
              ),
              Text(
                LOGO_TITLE,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // logout function
              final bool isLoggedOut = await user.logout();

              if (isLoggedOut) {
                // ignore: use_build_context_synchronously
                Navigator.popAndPushNamed(context, WelcomeScreen.screenRoute);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      );
}
