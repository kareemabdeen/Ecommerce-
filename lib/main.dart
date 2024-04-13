import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/auth.dart';
import 'utilities/router.dart';
import 'utilities/routes.dart';
import 'views/pages/check_out_page.dart';

late String intialRoute;
void detectIntialRouteForOurapp() {
  Auth.getInstance().authStateChanges.listen(
    (user) {
      if (user == null) // firstTime
      {
        intialRoute = AppRoutes.authPageRoute;
      } else {
        intialRoute = AppRoutes.bottomNavBarRoute;
      }
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  detectIntialRouteForOurapp();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) =>
          Auth.getInstance(), // singleton here applied by myself
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce App',
        // TODO : Refactor this theme away from the main file
        theme: getLightThemeData(context),
        onGenerateRoute: onGenerateRoutes,
        // initialRoute: intialRoute,
        home: const CheckOutPage(),
      ),
    );
  }

  ThemeData getLightThemeData(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFE5E5E5),
      primaryColor: Colors.red,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: Theme.of(context).textTheme.titleMedium,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
