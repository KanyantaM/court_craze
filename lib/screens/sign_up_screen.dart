import 'package:country_picker/country_picker.dart';
import 'package:court_craze/screens/layout.dart';
import 'package:court_craze/screens/log_in_screen.dart';
import 'package:court_craze/widgets/custom_app_bar.dart';
import 'package:court_craze/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Country? _selectedCountry;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _selectCountry(Country country) {
    setState(() {
      _selectedCountry = country;
      countryController.text = country.displayName;
    });
  }

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .whenComplete(() => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Layout())));
      // Successfully signed up
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('User signed up: ${userCredential.user?.email}')),
      );
      // Navigate to another screen if necessary
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'Failed to sign up: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 50),
              Text(
                'Create your Craze ID',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              openingMessage(context),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: false,
                    onSelect: (Country country) {
                      _selectCountry(country);
                    },
                  );
                },
                child: TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    enabled: false,
                    prefixIcon: Text(_selectedCountry?.flagEmoji ?? '🏁'),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              CustomElevatedButton(
                onTap: _signUp,
                title: 'Create Account',
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Center openingMessage(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              const TextSpan(
                text:
                    'Save your App preferences, see personalised content no matter what device you\'re on, and get exclusive benefits like game ticket giveaways, seat upgrades, merch deals and more.\n \n',
              ),
              TextSpan(
                text:
                    'Already have an account? You are already set up with Craze ID. ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInScreen()),
                    );
                  },
                  child: const Text(
                    'Sign In',
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
    );
  }
}
