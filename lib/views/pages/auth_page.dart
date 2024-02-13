import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/Providers/auth_controller_provider.dart';
import '../../utilities/assets.dart  (where is generated file to be)/assets.dart';
import '../../utilities/enums.dart';
import '../../utilities/routes.dart';
import '../widgets/main_button.dart';
import '../widgets/main_daliog_widget.dart';
import '../widgets/social_media_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<AuthController>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 60.0,
              horizontal: 32.0,
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 80.0),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      onChanged:
                          model.updateEmail, //! recheck this again tommorow
                      onEditingComplete: () => moveFocusToSecondField(),
                      textInputAction: TextInputAction.done,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your email!' : null,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email!',
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      onChanged:
                          model.updatePassword, //! recheck this again tommorow
                      validator: passwordValidation,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your pasword!',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    if (model.authFormType == AuthFormType.login)
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: const Text('Forgot your password?'),
                          onTap: () {},
                        ),
                      ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    MainButton(
                      text: model.authFormType == AuthFormType.login
                          ? 'Login'
                          : 'Register',
                      onTap: () {
                        //! in order to return back the states of the text fields before going to the second page

                        if (_formKey.currentState!.validate()) {
                          debugPrint('ana 3amlet etsk wekolo tamam ');

                          _formKey.currentState!
                              .save(); //Todo: saving user inputs to variables will be created lately
                          _submit(model: model);
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Text(
                          model.authFormType == AuthFormType.login
                              ? 'Don\'t have an account? Register'
                              : 'Have an account? Login',
                        ),
                        onTap: () {
                          _formKey.currentState!.reset();
                          model.toggleAuthFormType();
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.authFormType == AuthFormType.login
                              ? 'Or Login with'
                              : 'Or Register with',
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    SizedBox(height: size.height * .09),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaButton(
                          iconName: Assets.imagesGoogleSvgrepoCom,
                          onPress: () {},
                        ),
                        const SizedBox(width: 16.0),
                        SocialMediaButton(
                          iconName: Assets.imagesGoogleSvgrepoCom,
                          onPress: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit({required AuthController model}) async {
    // try {
    //   await model.submit();
    //false => return
    //   if (!mounted) return;
    // } catch (e) {
    //   MainDialog(
    //     context: context,
    //     title: 'Error Authentication',
    //     content: e.toString(),
    //   ).showAlertDialog();
    // }
    await model
        .submit()
        .then(
          (_) => Navigator.pushNamed(
            context,
            AppRoutes.bottomNavBarRoute,
          ),
        )
        .catchError(
      (e) {
        return MainDialog(
          context: context,
          title: 'Error Authentication',
          content: e.toString(),
        ).showAlertDialog();
      },
    );
  }

  String? passwordValidation(val) =>
      val!.isEmpty ? 'Please enter your password!' : null;

  void moveFocusToSecondField() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
