import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/auth_controller_provider.dart';
import '../widgets/main_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: Column(
        children: [
          const Spacer(),
          Consumer<AuthController>(
            builder: (context, model, __) {
              () {
                return MainButton(
                  text: 'Log out',
                  onTap: () async {
                    final logOut =
                        await context.read<AuthController>().logOut().then(
                              (_) => Navigator.pop(context),
                            );
                  },
                );
              };
            },
          ),
        ],
      ),
    );
  }
}
