import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:messageme_app/src/providers/user_provider.dart';
import 'package:messageme_app/src/views/screens/chat_screen.dart';
import 'package:messageme_app/src/views/screens/login_screen.dart';
import 'package:messageme_app/src/views/theme/app_colors.dart';
import 'package:messageme_app/src/views/widgets/logo_image_widget.dart';
import 'package:messageme_app/src/views/widgets/main_button_widget.dart';
import 'package:messageme_app/utils/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/text_button_widget.dart';
import '../widgets/text_form_field_widget.dart';

class RegisterScreen extends ConsumerWidget {
  static const String screenRoute = '/register_screen';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch<UserProviderApi>(userProvider);
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: user.loading,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LogoImageWidget(height: bigLogoImageHeight(context)),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormFieldWidget(
                            name: "Email",
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormFieldWidget(
                            name: "Password",
                            controller: _passwordController,
                            isPasswordField: true,
                          ),
                          MainButtonWidget(
                            title: "Sign Up",
                            color: AppColors.secondaryColor,
                            onPressed: () =>
                                _validateFormThenRegister(context, user),
                          ),
                        ],
                      ),
                    ),
                    TextButtonWidget(
                      onPressed: () =>
                          Navigator.pushNamed(context, LoginScreen.screenRoute),
                      fgColor: AppColors.primaryColor,
                      child: const Text("Already have an account?"),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void _validateFormThenRegister(
      BuildContext context, UserProviderApi user) async {
    // validate
    final bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    final bool isRegistered =
        await user.register(_emailController.text, _passwordController.text);

    if (isRegistered) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ChatScreen.screenRoute);
    }
  }
}
