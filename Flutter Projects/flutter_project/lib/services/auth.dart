import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase{
  User? get currentUser;
  Stream<User?> authStateChange();
  Future<User?> signInAnonymously();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase{
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChange() => FirebaseAuth.instance.authStateChanges();

  @override
  User? get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<User?> signInAnonymously() async{
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User?> signInWithGoogle() async{
    final googleSignIn = GoogleSignIn();
    final googlUser = await googleSignIn.signIn();

    if(googlUser != null){
      final googleAuth = await googlUser.authentication;
      if(googleAuth.idToken != null){
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
        ));
        return userCredential.user;
      }else{
        throw FirebaseAuthException(
            code: 'MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google Id Token'
        );
      }
    }else{
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user'
      );
    }
  }

  @override
  Future<User?> signInWithFacebook() async{
    final facebookSignIn = FacebookLogin();
    final response = await facebookSignIn.logIn(
      permissions: [FacebookPermission.publicProfile,
        FacebookPermission.email]
    );

    switch (response.status){
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken!.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
            code: 'ERROR_ABORTED_BY_USER',
            message: 'Sign in aborted by user'
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            code: 'ERROR_FACEBOOK_LOGIN_FAILED',
            message: response.error?.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async{
    final googlleSignIn = GoogleSignIn();
    await googlleSignIn.signOut();
    final facebookSignIn = FacebookLogin();
    await facebookSignIn.logOut();
    await _firebaseAuth.signOut();
  }
}