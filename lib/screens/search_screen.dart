// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'chat_screen.dart';

class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user, {super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No such user found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (var user in value.docs) {
        if (user.data()['email'] != widget.user.email) {
          searchResult.add(user.data());
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Add'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Type Username",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  onSearch();
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          if (searchResult.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(searchResult[index]['image']),
                    ),
                    title: Text(searchResult[index]['name']),
                    subtitle: Text(searchResult[index]['email']),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.text = "";
                          // searchResult = [];
                        });
                        // onSearch();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      currentUser: widget.user,
                                      friendId: searchResult[index]['uid'],
                                      friendName: searchResult[index]['name'],
                                      friendImage: searchResult[index]['image'],
                                    )));
                      },
                      icon: const Icon(Icons.message),
                    ),
                  );
                },
              ),
            )
          else if (isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
