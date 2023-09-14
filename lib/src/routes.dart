import 'package:messageme_app/src/views/screens/chat_screen.dart';
import 'package:messageme_app/src/views/screens/login_screen.dart';
import 'package:messageme_app/src/views/screens/register_screen.dart';
import 'package:messageme_app/src/views/screens/welcome_screen.dart';

class RouteManager {
  static final routes = {
    WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
    LoginScreen.screenRoute: (context) => LoginScreen(),
    RegisterScreen.screenRoute: (context) => RegisterScreen(),
    ChatScreen.screenRoute: (context) => ChatScreen(),
  };
}
