import 'package:flutter/material.dart';
import 'package:messageme_app/src/views/screens/login_screen.dart';
import 'package:messageme_app/src/views/screens/register_screen.dart';
import 'package:messageme_app/src/views/theme/app_colors.dart';
import 'package:messageme_app/src/views/widgets/logo_image_widget.dart';
import 'package:messageme_app/src/views/widgets/main_button_widget.dart';
import 'package:messageme_app/utils/constants.dart';

class WelcomeScreen extends StatelessWidget {
  static const String screenRoute = '/welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LogoImageWidget(height: bigLogoImageHeight(context)),
                  const Text(
                    LOGO_TITLE,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff2e386b),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MainButtonWidget(
                    title: "Login",
                    color: AppColors.primaryColor,
                    onPressed: () => Navigator.pushNamed(context, LoginScreen.screenRoute),
                  ),
                  MainButtonWidget(
                    title: "Sign Up",
                    color: AppColors.secondaryColor,
                    onPressed: () => Navigator.pushNamed(context, RegisterScreen.screenRoute),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
