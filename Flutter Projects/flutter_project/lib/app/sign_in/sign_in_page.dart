import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:flutter_project/app/sign_in/email_sign_in_page.dart';
import 'package:flutter_project/app/sign_in/sign_in_bloc.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import 'sign_in_button.dart';
import 'social_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context){
    return Provider<SignInBloc>(
        create: (context) => SignInBloc(),
        child: const SignInPage(),
    );
  }
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception){
    if(exception is FirebaseException && exception.code == "ERROR_ABORTED_BY_USER"){
      return;
    }
    showExceptionAlertDialog(
        context,
        title: "Sign in failed",
        exception: exception
    );
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _signInWithGoogle(BuildContext context) async{
    setState(() {
      _isLoading = true;
    });
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth!.signInWithGoogle();
    }on Exception catch(e){
      _showSignInError(context, e);
    }finally{
      setState((){
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async{
    setState(() {
      _isLoading = true;
    });
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth!.signInWithFacebook();
    }on Exception catch(e){
      _showSignInError(context, e);
    }finally{
      setState((){
        _isLoading = false;
      });
    }
  }

  Future<void> _signInAnonymously(BuildContext context) async{
    setState(() {
      _isLoading = true;
    });
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth!.signInAnonymously();
    }on Exception catch(e){
      _showSignInError(context, e);
    }finally{
      setState((){
        _isLoading = false;
      });
    }
  }

  void _signInWithEmail(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => EmailSignInPage(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildContent(context, snapshot.data);
        }
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context, bool? isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
              child: _buildHeader()
          ),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            text: "Sign in with Google",
            textColor: Colors.black,
            onPressed: _isLoading ? null : () => _signInWithGoogle(context),
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
            onPressed: _isLoading ? null : () => _signInWithFacebook(context),
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
            onPressed: _isLoading ? null : () => _signInWithEmail(context),
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
              onPressed: _isLoading ? null : () => _signInAnonymously(context),
              color: Colors.lime[300],
              height: 50.0
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(){
    if(_isLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
