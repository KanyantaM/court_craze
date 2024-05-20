import 'package:flutter/material.dart';

class PrivacyPopup {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to Court Craze! Your privacy is important to us. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about our policy, or our practices with regards to your personal information, please contact us.',
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  'We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and services, when you participate in activities on the app, or otherwise when you contact us.',
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  'We use the information we collect or receive to communicate directly with you. We may also send you marketing emails related to the use of our services, but you can opt out at any time.',
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  'We do not share your information with third parties without your consent, except to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.',
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10),
                Text(
                  'For more detailed information, please review our full privacy policy on our website.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
