import 'package:court_craze/components/widgets/custom_elevated_button.dart';
import 'package:court_craze/screens/views/authentication/log_in_screen.dart';
import 'package:court_craze/screens/views/authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key, required this.title});

  final String title;

  @override
  State<GetStartedScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            splashScreenLogo(),
            splashScreenMessage(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  title: 'Get Started',
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(
                            text: 'Already have a CourtCraze Account? ',
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                );
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding splashScreenMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Welcome to the Court Craze App',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          Center(
            child: SizedBox(
              width: 350,
              child: Text(
                'sign in or sign up to personalise your app experience, save your preferences, and get access to live games and exclusive content and benefits all in the app.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center splashScreenLogo() {
    return Center(
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/basketball_colour.png',
            scale: 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/court_craze.png',
            scale: 3.5,
          ),
        ),
      ]),
    );
  }
}
