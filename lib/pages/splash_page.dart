import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_portfolio/common/my_route/my_route.gr.dart';
import 'package:media_portfolio/services/firebase_auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Firebase.initializeApp().then((value) {
      Future.delayed(Duration(seconds: 2)).then((value) {
        var firebaseAuthService = FirebaseAuthService();
        if (firebaseAuthService.currentUser != null) {
          AutoRouter.of(context).replace(HomeRoute());
        } else {
          AutoRouter.of(context).replace(LoginRoute());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('Media Portfolio'),
      ),
    );
  }
}
