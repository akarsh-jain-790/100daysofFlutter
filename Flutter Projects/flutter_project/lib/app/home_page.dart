import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.onSignOut, required this.auth}) : super(key: key);
  final VoidCallback onSignOut;
  final AuthBase auth;

  Future<void> _signOut() async{
    try{
      await auth.signOut();
      onSignOut();
    }catch(e){
      print("Unable to logout ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: <Widget>[
          TextButton(
            onPressed: _signOut,
            child: const Text(
              "Logout",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {  },
          child: Text("Hello"),
        ),
      ),
    );
  }
}
