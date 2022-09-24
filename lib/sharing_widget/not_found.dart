import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  final String message;
  const NotFoundPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset("ib/assets/images/Icon/sad.png"),
          const SizedBox(height: 30),
          Text(message, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
