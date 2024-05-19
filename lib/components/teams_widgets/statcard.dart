import 'package:flutter/material.dart';
import 'package:court_craze/components/style.dart';

class StatCard extends StatelessWidget {
  final String item1, item2, item3, item4;
  const StatCard({
    super.key,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 75,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFFEDF1FF),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item1,
              style: styleDesign,
            ),
            Text(
              item2,
              style: styleDesign,
            ),
            Text(
              item3,
              style: styleDesign,
            ),
            Text(
              item4,
              style: styleDesign,
            ),
          ],
        ),
      ),
    );
  }
}
