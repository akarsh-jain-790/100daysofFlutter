import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_project/app/sign_in/validator.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../common_widgets/form_submit_button.dart';
import '../common_widgets/show_alert_dialog.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
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
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
        showExceptionAlertDialog(
          context,
          title: "Sign in failed",
          exception: e
        );
    }finally{
      setState((){
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus );
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) && !_isLoading;

    bool showErrorTextEmail = _submitted && !widget.emailValidator.isValid(_email);
    bool showErrorTextPassword = _submitted && !widget.passwordValidator.isValid(_password);

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
          hintText: "test@test.com",
          errorText: showErrorTextEmail ? widget.invalidEmailErrorText : null,
          enabled: _isLoading == false,
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        textInputAction: TextInputAction.done,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onChanged: (password) => _updateState(),
        decoration: InputDecoration(
          labelText: "Password",
          errorText: showErrorTextPassword ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading == false,
        ),
        obscureText: true,
        onEditingComplete: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressedCall: submitEnabled ? _submit : null,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(secondaryText, style: TextStyle(color: Colors.black87)),
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
    setState(() {});
  }
}
