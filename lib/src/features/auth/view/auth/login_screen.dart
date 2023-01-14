import 'package:flutter/material.dart';

import 'package:atlas_coins/src/theme/constants.dart';
import 'package:atlas_coins/src/components/app_bar_app.dart';
import 'package:atlas_coins/src/components/button_widget.dart';
import 'package:atlas_coins/src/components/base_structure.dart';
import 'package:atlas_coins/src/features/auth/controller/auth_controller.dart';
import 'package:atlas_coins/src/features/auth/view/auth/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseStructure(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBarApp(
              onPressed: () {},
              title: "Entrar",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(size20),
              child: ButtonWidget(
                label: "Entrar",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.signInController(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
