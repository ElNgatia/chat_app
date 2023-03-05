import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/message_textfield.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;

  const ChatScreen(
      {super.key, required this.currentUser,
      required this.friendId,
      required this.friendName,
      required this.friendImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(friendImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(friendName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(),
            ),
          ),
          MessageTextField(currentUser.uid, friendId),
        ],
      ),
    );
  }
}
