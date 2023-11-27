import 'package:flutter/material.dart';
import 'package:sidekick_app/main.dart';
import 'package:sidekick_app/navigation_menu.dart';
import 'package:sidekick_app/screens/authentication/forgot_password.dart';
import 'package:sidekick_app/screens/authentication/login_screen.dart';
import 'package:sidekick_app/screens/authentication/signup_screen.dart';
import 'package:sidekick_app/screens/event/add_event.dart';

class AppRoutes {
  static const home = "/";
  static const main = "main";
  static const login = 'login';
  static const signup = 'signup';
  static const String forgotPassword = 'forgot_password';
  static const navigation = 'navigation';
  static const String addEvent = "add_event";
  static const String editEvent = "edit_event";
  static const String viewEvent = "view_event";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
            case addEvent:
              return const AddEventPage();
            case home:
              return const MainPage();
            case login:
              return const LoginScreen();
            case signup:
              return const SignUpScreen();
            case forgotPassword:
              return const ForgotPassword();
            case navigation:
              return const NavigationMenu();
            case main:
            default:
              return const MainPage();
          }
        });
  }
}
