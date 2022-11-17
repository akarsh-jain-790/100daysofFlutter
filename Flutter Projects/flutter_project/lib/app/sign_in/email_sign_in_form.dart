import 'package:flutter/material.dart';

class EmailSignInForm extends StatelessWidget {
  const EmailSignInForm({Key? key}) : super(key: key);

  List<Widget> _buildChildren(){
    return const [
      TextField(
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "test@test.com"
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: "Password"
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
          onPressed: null,
          child: Text("Sign In")
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
          onPressed: null,
          child: Text("Need an account? Register")
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}



