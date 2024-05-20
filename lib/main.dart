import 'package:court_craze/firebase_options.dart';
import 'package:court_craze/json/jsons.dart';
import 'package:court_craze/screens/views/authentication/get_started_screen.dart';
import 'package:court_craze/screens/layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialScreen() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return ChangeNotifierProvider<JsonFiles>(
        create: (context) => JsonFiles(),
        child: const Layout(),
      );
    } else {
      return const GetStartedScreen(title: 'Court Craze');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _getInitialScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        } else {
          return ChangeNotifierProvider<JsonFiles>(
            create: (context) => JsonFiles(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Court Craze',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE8E8E8)),
                useMaterial3: true,
              ),
              home: snapshot.data,
            ),
          );
        }
      },
    );
  }
}
