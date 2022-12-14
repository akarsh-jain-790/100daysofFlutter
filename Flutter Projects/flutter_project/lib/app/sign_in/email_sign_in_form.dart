import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../common_widgets/form_submit_button.dart';

enum EmailSignInFormType {signIn, register}

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void  _submit() async{
    try {
      if(_formType == EmailSignInFormType.signIn){
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      }else{
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _emailEditingComplete(){
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType(){
      setState(() {
        _formType = _formType == EmailSignInFormType.signIn ?
            EmailSignInFormType.register : EmailSignInFormType.signIn;
      });
      _emailController.clear();
      _passwordController.clear();
  }

  List<Widget> _buildChildren(){
    final primaryText = _formType == EmailSignInFormType.signIn ?
        'Sign In' : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn ?
        'Need an account? Register' : 'Have an account? Sign in';

    bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;

    return [
      TextField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: _emailController,
        focusNode: _emailFocusNode,
        onEditingComplete: _emailEditingComplete,
        onChanged: (email) => _updateState(),
        decoration: InputDecoration(
          labelText: "Email",
          hintText: "test@test.com"
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onChanged: (email) => _updateState(),
        decoration: InputDecoration(
            labelText: "Password"
        ),
        obscureText: true,
        onEditingComplete: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressedCall: () { },
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
          onPressed: _toggleFormType,
          child: Text(
              secondaryText,
              style: TextStyle(
                color: Colors.black87
              )
          ),
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

  void _updateState() {
    print("hello");
  }
}

