import 'package:flutter/material.dart';
import 'package:court_craze/components/teams_widgets/teams.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: teams(context),
    );
  }
}
