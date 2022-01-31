import 'package:flash_chat/components/wide_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

  static const String id = 'Registration_Screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool spinner = false;

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kInputTextFieldDecoration.copyWith(hintText: 'Enter you email')
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                  textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kInputTextFieldDecoration.copyWith(hintText: 'Enter your password')
              ),
              SizedBox(
                height: 24.0,
              ),
              WideButton(onPressed: () async{
                setState(() {
                  spinner = true;
                });
                try {
                  final newUser = await
                  _auth.createUserWithEmailAndPassword(
                      email: email.trim(), password: password.trim());
                  if (newUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    spinner = false;
                  });
                } catch (e) {
                  print (e);
                  setState(() {
                    spinner = false;
                  });
                }
                },
                  title: 'Register', backgroundColor: Colors.blueAccent)],
          ),
        ),
      ),
    );
  }
}
