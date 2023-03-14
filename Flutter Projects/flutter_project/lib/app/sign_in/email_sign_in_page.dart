import 'package:flutter/material.dart';
import 'package:flutter_project/app/sign_in/email_sign_in_form.dart';

import '../../services/auth.dart';

class EmailSignInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInForm(),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
