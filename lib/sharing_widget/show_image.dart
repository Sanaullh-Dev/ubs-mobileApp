import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String? imageUrl;
  const ShowImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? "",
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(
          "lib/assets/images/not_found.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ShowUserPhoto extends StatelessWidget {
  final String imageUrl;
  const ShowUserPhoto({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          "lib/assets/images/user.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
