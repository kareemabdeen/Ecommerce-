import 'package:flutter/cupertino.dart';

import '../views/pages/auth_page.dart';
import '../views/pages/bottom_nav_bar.dart';
import '../views/pages/cart_page.dart';
import '../views/pages/favourite_page.dart';
import '../views/pages/home_page.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/profile_page.dart';
import 'routes.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    // return CupertinoPageRoute(
    //   builder: (context) {
    //     final auth = Provider.of<AuthBase>(context);
    //     final authController = AuthController(authBase: auth);
    //     return ChangeNotifierProvider(
    //       create: (context) => authController,
    //       child: const AuthPage(),
    //     );
    //   },
    //   settings: settings,
    // );
    case AppRoutes.authPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );

    case AppRoutes.profilePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const ProfilePage(),
        settings: settings,
      );

    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavBar(),
        settings: settings,
      );

    case AppRoutes.favouritePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const FavouritePage(),
        settings: settings,
      );

    case AppRoutes.cartPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const CartPage(),
        settings: settings,
      );

    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (_) => const HomePage(),
        settings: settings,
      );

    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
