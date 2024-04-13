import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/auth_controller_provider.dart';
import '../../services/auth.dart';
import '../../utilities/routes.dart';
import '../widgets/main_button.dart';
import '../widgets/main_daliog_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final auth = Provider.of<AuthBase>(context, listen: false);
        return AuthController(authBase: auth);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<AuthController>(
            builder: (_, model, __) => MainButton(
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
    await model.logOut().then(
      (_) {
        return Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamedAndRemoveUntil(
          AppRoutes.authPageRoute,
          (route) => false,
        );
      },
    ).catchError(
      (error) {
        return MainDialog(
          content: error.toString(),
          context: context,
          title: "Sign out Error",
        ).showAlertDialog();
      },
    );
  }
}
