import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/screens/authentication/verify_email.dart';
import 'package:sidekick_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sidekick_app/utils/colours.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyACB6nWFNDqXJ7bjbmYCqPLRlAquTXU89c",
            appId: "1:295527037220:web:3ae2b3b571acd8a1055bb1",
            messagingSenderId: "295527037220",
            projectId: "sidekickapp-10912"));
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final messengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Sidekick',
      theme:
          ThemeData(scaffoldBackgroundColor: bgcolor, fontFamily: 'Gaegu-Bold'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // ignore: unrelated_type_equality_checks
          if (snapshot.connectionState == ConnectionState) {
            return const Center(
                child: CircularProgressIndicator(color: yellow));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong.'),
            );
          } else if (snapshot.hasData) {
            return const VerifyEmail();
          } else {
            return const WelcomeScreen();
          }
        },
      ));
}
