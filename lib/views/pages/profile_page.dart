import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/auth_controller_provider.dart';
import '../widgets/main_button.dart';
import '../widgets/main_daliog_widget.dart';
import 'auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Spacer(),
          Consumer<AuthController>(
            builder: (context, model, child) => MainButton(
              text: 'Log out',
              hasCircularBorder: true,
              onTap: () async {
                //! recheck it again is it using .read or not
                await _logOut(model: model, context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logOut(context, {required AuthController model}) async {
    return await model.logOut().then(
      (_) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
            (route) => false);
      },
    ).catchError(
      (error) {
        MainDialog(
          content: error.toString(),
          context: context,
          title: "Sign out Error",
        ).showAlertDialog();
      },
    );
  }
}
