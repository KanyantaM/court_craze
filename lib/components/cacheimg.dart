import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//FIXME: widget throws error when no image is stored in cache
class CachedLogo extends StatelessWidget {
  final String url;
  final double radius;
  const CachedLogo({super.key, required this.url, required this.radius});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
