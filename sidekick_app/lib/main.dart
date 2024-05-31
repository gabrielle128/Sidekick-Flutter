import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sidekick_app/firebase_options.dart';
import 'package:sidekick_app/routes.dart';
import 'package:sidekick_app/screens/authentication/verify_email.dart';
import 'package:sidekick_app/screens/wallet/add_expense.dart';
import 'package:sidekick_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sidekick_app/utils/colours.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyACB6nWFNDqXJ7bjbmYCqPLRlAquTXU89c",
            appId: "1:295527037220:web:3ae2b3b571acd8a1055bb1",
            messagingSenderId: "295527037220",
            projectId: "sidekickapp-10912"));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
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
      title: 'Workada',
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              surface: bgcolor,
              onSurface: black,
              primary: mustard,
              secondary: navy,
              tertiary: moss,
              outline: grey),
          scaffoldBackgroundColor: bgcolor,
          primaryColor: yellow,
          fontFamily: 'Gaegu-Bold',
          appBarTheme: const AppBarTheme(backgroundColor: bgcolor)),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // home: AddExpense(),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the main screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/workada_logo.png',
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),
            const SizedBox(height: 20),
            const Text(
              'Workada',
              style: TextStyle(
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
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
