import 'package:flutter/material.dart';
import 'package:sidekick_app/navigation_menu.dart';
import 'package:sidekick_app/screens/event/add_event.dart';
import 'package:sidekick_app/screens/welcome_screen.dart';

class AppRoutes {
  static const home = "/";
  static const main = "main";
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
              return const WelcomeScreen();
            case main:
            default:
              return const NavigationMenu();
          }
        });
  }
}
