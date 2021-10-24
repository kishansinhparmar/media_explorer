import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static final FirebaseAuthService _instance = FirebaseAuthService._internal();

  FirebaseAuthService._internal();

  factory FirebaseAuthService() {
    return _instance;
  }

  static FirebaseAuthService get instance => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  User? get currentUser => _firebaseAuth.currentUser;

  /// Once server send OTP successfully then we have to verify mobile number and
  /// this function will return us different callbacks.
  void verifyMobileNumber(
    String mobile, {

    /// Auto detect SMS callback
    required PhoneVerificationCompleted autoDetectSMSCallback,

    /// Code sent successfully
    required PhoneCodeSent otpSentSuccessfullyCallback,

    /// Something wrong in auth
    required Function(FirebaseAuthException) authException,

    /// Timeout
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),

        // Auto detect SMS callback
        verificationCompleted: autoDetectSMSCallback,

        // Something wrong in auth
        verificationFailed: authException,

        // Code successfully sent to the mobile number
        codeSent: otpSentSuccessfullyCallback,

        // Code auto retrieval timeout
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  /// Once PhoneCodeSent callback called (Means OTP sent successfully )
  Future<UserCredential?> signInWithAuthCredentials(
      AuthCredential credential) async {
    try {
      _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  /// This method is useful well we aren't using any firebase sign-in methods
  /// but server will generate a credentials for us to verify a user.
  Future signInWithCustomToken(String token) async {
    try {
      return _firebaseAuth.signInWithCustomToken(token);
    } catch (e) {
      throw e;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      var googleSignIn = await _googleSignIn.signIn();
      if (googleSignIn != null) {
        final GoogleSignInAuthentication googleAuthCredential =
            await googleSignIn.authentication;
        final UserCredential userCredentials =
            await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuthCredential.idToken,
            // Note: Access token is null when running on web, so we don't check for it above
            accessToken: googleAuthCredential.accessToken,
          ),
        );

        return userCredentials.user;
      } else {
        throw Exception('Google user is null');
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      return _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  String? getUserUniqueId() {
    if (_firebaseAuth.currentUser != null) {
      return _firebaseAuth.currentUser!.uid;
    } else {
      return null;
    }
  }

  String getUniqueFileName() {
    var random = Random.secure();
    var values = List<int>.generate(10, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}

// class AppUser {
//   final String? uid;
//   final String? email;
//   final String? photoURL;
//   final String? displayName;
//
//   const AppUser({
//     @required this.uid,
//     this.email,
//     this.photoURL,
//     this.displayName,
//   }) : assert(uid != null, 'User can only be created with a non-null uid');
//
//   factory AppUser.fromFirebaseUser(User? user) {
//     // if (user == null) {
//     //   return null;
//     // }
//     return AppUser(
//       uid: user?.uid,
//       email: user?.email,
//       displayName: user?.displayName,
//       photoURL: user?.photoURL,
//     );
//   }
//
//   @override
//   String toString() =>
//       'uid: $uid, email: $email, photoUrl: $photoURL, displayName: $displayName';
// }

/// Unused code for firebase auth

// Stream<AppUser?> authStateChanges() {
//   return _firebaseAuth
//       .authStateChanges()
//       .map((user) => AppUser.fromFirebaseUser(user));
// }
// Future<AppUser> signInAnonymously() async {
//   final userCredential = await _firebaseAuth.signInAnonymously();
//   return AppUser.fromFirebaseUser(userCredential.user);
// }
//
// Future<AppUser> signInWithEmailAndPassword(
//     String email, String password) async {
//   final userCredential =
//       await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
//     email: email,
//     password: password,
//   ));
//   return AppUser.fromFirebaseUser(userCredential.user);
// }
//
// Future<AppUser> createUserWithEmailAndPassword(
//     String email, String password) async {
//   final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
//       email: email, password: password);
//   return AppUser.fromFirebaseUser(userCredential.user);
// }
//
// Future<void> sendPasswordResetEmail(String email) async {
//   await _firebaseAuth.sendPasswordResetEmail(email: email);
// }
