// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'auth_screen.dart';
import 'package:profanity_filter/profanity_filter.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  UserModel user;

  HomeScreen(
    this.user, {
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToAuthScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              _navigateToAuthScreen(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(widget.user.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return const Center(
                  child: Text("No chats yet"),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var friendId = snapshot.data.docs[index].id;
                  var lastMessage = snapshot.data.docs[index]["lastMessage"];
                  String filteredLastMessage =
                      ProfanityFilter().censor(lastMessage);
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(friendId)
                        .get(),
                    builder: (context, AsyncSnapshot asyncsnapshot) {
                      if (asyncsnapshot.hasData) {
                        var friend = asyncsnapshot.data;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(friend['image']),
                          ),
                          title: Text(friend['name']),
                          subtitle: Text(
                            filteredLastMessage,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                        currentUser: widget.user,
                                        friendId: friend['uid'],
                                        friendName: friend['name'],
                                        friendImage: friend['image'])));
                          },
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(widget.user)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
