import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFE8E8E8)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(203, 52),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
