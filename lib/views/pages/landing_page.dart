import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/auth_controller_provider.dart';
import '../../services/auth.dart';
import 'auth_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //! ليه اكسسنا الاوس عن طريق البروفايدر هنا
    final auth = Provider.of<AuthBase>(context);

    return StreamBuilder<User?>(
      stream: Auth.getInstance().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(authBase: auth),
              child: const AuthPage(),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
