import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final ProfanityFilter filter;
  
  const SingleMessage({
    super.key,
    required this.message,
    required this.isMe,
    required this.filter,
  });

  @override
  Widget build(BuildContext context) {
    final filteredMessage = filter.censor(message);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMe ? Colors.blueGrey : Colors.blueGrey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filteredMessage,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
