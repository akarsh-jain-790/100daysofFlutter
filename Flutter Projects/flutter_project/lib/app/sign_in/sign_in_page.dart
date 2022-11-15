import 'package:flutter/material.dart';

import '../../services/auth.dart';
import 'sign_in_button.dart';
import 'social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this. auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInAnonymously() async{
    try{
      await auth.signInAnonymously();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            textColor: Colors.black,
            onPressed: _sign_in_with_google,
            color: Colors.white,
            height: 50.0,
            assetName: 'images/google-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            text: "Sign in with Facebook",
            textColor: Colors.white,
            onPressed: _sign_in_with_google,
            color:  Color(0xFF334D92),
            height: 50.0,
            assetName: 'images/facebook-logo.png',
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Sign in with email",
            textColor: Colors.white,
            onPressed: _sign_in_with_google,
            color: Colors.teal[700],
            height: 50.0
          ),
          const SizedBox(
            height: 8.0,
          ),
         const Text(
            "or",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: "Go anonymous",
              textColor: Colors.black,
              onPressed: _signInAnonymously,
              color: Colors.lime[300],
              height: 50.0
          ),
        ],
      ),
    );
  }
}
void _sign_in_with_google() {
  print("clicked");
}
