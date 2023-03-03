import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/14/14558.png"),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
