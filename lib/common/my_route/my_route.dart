import 'package:auto_route/annotations.dart';
import 'package:media_portfolio/pages/add_image_page.dart';
import 'package:media_portfolio/pages/home_page.dart';
import 'package:media_portfolio/pages/image_full_screen_preview_page.dart';
import 'package:media_portfolio/pages/login_page.dart';
import 'package:media_portfolio/pages/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: ImageFullScreenPreviewPage),
    AutoRoute(page: AddImagePage),
    AutoRoute(page: LoginPage),
    // AutoRoute(page: AppWebviewPage),
    // AutoRoute(page: WebviewErrorPage),
    // AutoRoute(page: MyInAppWebviewPage),
    // AutoRoute(page: PaymentPage),
  ],
)
class $MyRouter {}
