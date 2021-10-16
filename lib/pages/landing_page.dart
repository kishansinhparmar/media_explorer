import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_portfolio/common/my_route/my_route.gr.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  MyRouter _appRouter = MyRouter();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((value) {
      RemoteConfig.instance.setDefaults(<String, dynamic>{
        'is_app_underdevelopment': false,
      });

      RemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(seconds: 10),
          minimumFetchInterval: Duration(seconds: 10),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        barBackgroundColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.white,
          darkColor: CupertinoColors.black,
        ),
        primaryColor: CupertinoDynamicColor.withBrightness(
          color: CupertinoColors.systemBlue,
          darkColor: CupertinoColors.systemGreen,
        ),
      ),
      // theme: ,
      // theme: ThemeData(
      //   primaryColor: Colors.blue,
      // ),
    );
  }
}
