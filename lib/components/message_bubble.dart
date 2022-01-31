import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  final String text;
  final String sender;
  final bool isMe;

  MessageBubble({@required this.text, @required this.sender, @required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: isMe == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text(sender, style:TextStyle(color: Colors.blueAccent)),
          ),
          Material(
            color: Colors.lightGreen,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text, style: TextStyle(fontSize: 20, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}