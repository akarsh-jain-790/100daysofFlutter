import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/services.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import 'home/jobs_page.dart';
import 'sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth!.authStateChange(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.active){
          final User? user = snapshot.data;
          if(user == null){
            return SignInPage.create(context);
          }
          return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: JobsPage(),
            );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}

