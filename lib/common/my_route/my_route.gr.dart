// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

import '../../pages/add_image_page.dart' as _i4;
import '../../pages/home_page.dart' as _i2;
import '../../pages/image_full_screen_preview_page.dart' as _i3;
import '../../pages/login_page.dart' as _i5;
import '../../pages/splash_page.dart' as _i1;

class MyRouter extends _i6.RootStackRouter {
  MyRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    ImageFullScreenPreviewRoute.name: (routeData) {
      final args = routeData.argsAs<ImageFullScreenPreviewRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ImageFullScreenPreviewPage(args.imageUrl, key: args.key));
    },
    AddImageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.AddImagePage());
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.LoginPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashRoute.name, path: '/'),
        _i6.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i6.RouteConfig(ImageFullScreenPreviewRoute.name,
            path: '/image-full-screen-preview-page'),
        _i6.RouteConfig(AddImageRoute.name, path: '/add-image-page'),
        _i6.RouteConfig(LoginRoute.name, path: '/login-page')
      ];
}

/// generated route for [_i1.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute() : super(name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.ImageFullScreenPreviewPage]
class ImageFullScreenPreviewRoute
    extends _i6.PageRouteInfo<ImageFullScreenPreviewRouteArgs> {
  ImageFullScreenPreviewRoute({required String imageUrl, _i8.Key? key})
      : super(name,
            path: '/image-full-screen-preview-page',
            args:
                ImageFullScreenPreviewRouteArgs(imageUrl: imageUrl, key: key));

  static const String name = 'ImageFullScreenPreviewRoute';
}

class ImageFullScreenPreviewRouteArgs {
  const ImageFullScreenPreviewRouteArgs({required this.imageUrl, this.key});

  final String imageUrl;

  final _i8.Key? key;
}

/// generated route for [_i4.AddImagePage]
class AddImageRoute extends _i6.PageRouteInfo<void> {
  const AddImageRoute() : super(name, path: '/add-image-page');

  static const String name = 'AddImageRoute';
}

/// generated route for [_i5.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/login-page');

  static const String name = 'LoginRoute';
}
