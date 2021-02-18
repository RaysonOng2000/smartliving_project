import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartliving_project/authenication.dart';
import 'package:smartliving_project/home.dart';

// Import pages
import 'welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// Main Function
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenicationService>(
          create: (_) => AuthenicationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenicationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'Smart Living',
        // Theme
        theme: ThemeData(
          primaryColor: Colors.indigo,
          primaryColorLight: Colors.indigo[200],
          errorColor: Colors.red,
          // Input Field Theme
          inputDecorationTheme: InputDecorationTheme(
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20.0),
            isDense: true,
            hintStyle: TextStyle(
              color: Colors.grey[600],
            ),
            labelStyle: TextStyle(
              color: Colors.grey[600],
            ),
            filled: true,
            fillColor: Colors.grey[200],
            border: InputBorder.none,
          ),
          // Button Theme
          buttonTheme: ButtonThemeData(
            padding: const EdgeInsets.all(15.0),
            buttonColor: Colors.indigo,
            highlightColor: Colors.indigo[200],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        // Display Page
        home: AuthenicationWrapper(),
      ),
    );
  }
}

class AuthenicationWrapper extends StatelessWidget {
  const AuthenicationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve current user logged in
    final firebaseUser = context.watch<User>();

    // Check if user is logged in
    if (firebaseUser != null) {
      return MainPage(firebaseUser);
    } else {
      return WelcomePage();
    }
  }
}
