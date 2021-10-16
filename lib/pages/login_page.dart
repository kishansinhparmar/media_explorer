import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:media_portfolio/common/my_route/my_route.gr.dart';
import 'package:media_portfolio/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                firebaseAuthService.signInWithGoogle().then(
                  (signedUser) {
                    if (signedUser != null) {
                      AutoRouter.of(context).replace(HomeRoute());
                    } else {
                      print('Something wrong with Google sign-in');
                    }
                  },
                ).onError((error, stackTrace) {
                  print('Something wrong with Google sign-in');
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
