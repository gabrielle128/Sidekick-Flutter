import 'package:flutter/material.dart';
import 'package:sidekick_app/main.dart';
import 'package:sidekick_app/navigation_menu.dart';
import 'package:sidekick_app/screens/account/aboutus_screen.dart';
import 'package:sidekick_app/screens/account/addfeedback_screen.dart';
import 'package:sidekick_app/screens/admin/admin_screen.dart';
import 'package:sidekick_app/screens/admin/feedback_screen.dart';
import 'package:sidekick_app/screens/admin/users_screen.dart';
import 'package:sidekick_app/screens/authentication/forgot_password.dart';
import 'package:sidekick_app/screens/authentication/login_screen.dart';
import 'package:sidekick_app/screens/authentication/signup_screen.dart';

class AppRoutes {
  static const home = "/";
  static const main = "main";
  static const login = 'login';
  static const signup = 'signup';
  static const String forgotPassword = 'forgot_password';
  static const navigation = 'navigation';
  static const aboutus = 'about us';
  static const admin = 'admin';
  static const users = 'users';
  static const feedback = 'feedback';
  static const addFeedback = 'addFeedback';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          switch (settings.name) {
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
            case aboutus:
              return const AboutUsScreen();
            case admin:
              return const AdminScreen();
            case users:
              return const UsersScreen();
            case feedback:
              return const FeedbackScreen();
            case addFeedback:
              return AddFeedback();
            case main:
            default:
              return const MainPage();
          }
        });
  }
}
