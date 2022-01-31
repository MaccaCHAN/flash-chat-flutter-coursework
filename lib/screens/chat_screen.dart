import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
bool isMe;

class ChatScreen extends StatefulWidget {

  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;
  final textFieldController = TextEditingController();

  String messageText;


  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser () {
    try {
    final user = _auth.currentUser;
    if (user != null){
      loggedInUser = user;
      print(loggedInUser.email);
    } } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStreamBuilder(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.black87),
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                      controller: textFieldController,

                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('messages').add
                        ({'text': messageText, 'sender' : loggedInUser.email, 'time' : FieldValue.serverTimestamp()});
                     textFieldController.clear();
                      //messageText + sender
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder <QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time', descending: true).snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageBubbleList = [];
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,));
          }
            final messages = snapshot.data.docs;
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final currentUser = loggedInUser.email;

              if (currentUser == messageSender) {
                isMe = true;
              } else {
                isMe = false;
              }

              final messageBubble = MessageBubble(text: messageText, sender: messageSender, isMe: isMe);
              messageBubbleList.add(messageBubble);
            }

            return Expanded(child: ListView(children: messageBubbleList, reverse: true) );
          },
    );
  }
}





