import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../controllers/Providers/auth_controller_provider.dart';
import '../controllers/Providers/database_controller.dart';
import '../services/auth.dart';
import '../views/pages/auth_page.dart';
import '../views/pages/bottom_nav_bar.dart';
import '../views/pages/cart_page.dart';
import '../views/pages/check_out_page.dart';
import '../views/pages/favourite_page.dart';
import '../views/pages/home_page.dart';
import '../views/pages/landing_page.dart';
import '../views/pages/product_details_page.dart';
import '../views/pages/profile_page.dart';
import 'routes.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.authPageRoute:
      return CupertinoPageRoute(
        builder: (context) {
          // TODO: change it later to ChangeNotifierProvider.value => to share this value over the remainging screens
          return ChangeNotifierProvider<AuthController>(
            create: (context) {
              final auth = Provider.of<AuthBase>(context, listen: false);
              return AuthController(authBase: auth);
            },
            child: const AuthPage(),
            builder: (context, child) => const AuthPage(),
          );
        },
        settings: settings,
      );
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => Provider<DataBase>(
          create: (context) {
            final uId = context.read<AuthBase>().currentUser!.uid;
            return FireStoreDataBase(
              currentUserId: uId, // user.id
            );
          },
          child: const BottomNavBar(),
        ),
        settings: settings,
      );
    case AppRoutes.profilePageRoute:
      return CupertinoPageRoute(
        builder: (context) {
          return ChangeNotifierProvider<AuthController>(
            create: (context) {
              final auth = Provider.of<AuthBase>(context, listen: false);

              return AuthController(authBase: auth);
            },
            child: const ProfilePage(),
          );
        },
        settings: settings,
      );

    case AppRoutes.productDetailsRoute:
      return CupertinoPageRoute(
        builder: (context) {
          final args = settings.arguments as Map<String, dynamic>;
          final DataBase database = args['database'];
          final selectedProduct = args['product'];

          return Provider.value(
            value: database,
            child: ProductDetailsPage(
              product: selectedProduct,
            ),
          );
        },
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

    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as DataBase;

      return CupertinoPageRoute(
        builder: (_) => Provider.value(
          value: database,
          child: const CheckOutPage(),
        ),
        settings: settings,
      );

    case AppRoutes.homePageRoute:
      return CupertinoPageRoute(
        builder: (context) {
          final args = settings.arguments as Map<String, dynamic>;
          final DataBase database = args['database'];

          return Provider.value(value: database, child: const HomePage());
        },
        settings: settings,
      );

    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
