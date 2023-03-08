import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/message_textfield.dart';
import 'package:chat_app/widgets/single_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class ChatScreen extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  final ProfanityFilter filter = ProfanityFilter();


  ChatScreen(
      {super.key,
      required this.currentUser,
      required this.friendId,
      required this.friendName,
      required this.friendImage,

      });

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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser.uid)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.isEmpty) {
                      return const Center(
                        child: Text('No messages yet'),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]["senderId"] ==
                              currentUser.uid;
                          String message = snapshot.data.docs[index]["message"];
                          String filteredMessage = ProfanityFilter().censor(message);
                          return SingleMessage(
                            filter: filter,
                              message: filteredMessage,
                              isMe: isMe);
                        });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          MessageTextField(currentUser.uid, friendId),
        ],
      ),
    );
  }
}
