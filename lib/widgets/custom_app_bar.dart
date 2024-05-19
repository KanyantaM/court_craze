import 'package:flutter/material.dart';

AppBar customAppBar({bool automaticallyImplyLeading = false, bool hamburger = false}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: logo(automaticallyImplyLeading),
    leading: hamburger
        ? Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )
        : null,
  );
}

Row logo(bool noCentre) {
  return Row(
      mainAxisAlignment:
          noCentre ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/basketball_colour.png',
            scale: 12,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/court_craze.png',
            scale: 7,
          ),
        ),
      ]);
}
