import 'package:flutter/material.dart';
import 'package:ubs/sharing_widget/show_image.dart';

class UserInfoBar extends StatelessWidget {
  final String url;
  final String userName;
  final VoidCallback onPress;
  const UserInfoBar(
      {super.key,
      required this.url,
      required this.userName,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 60, child: ShowImage(imageUrl: url)),
        ListTile(
            title: Text(userName), subtitle: Text("Member since Aug 2022")),
        Icon(Icons.arrow_forward_ios)
      ],
    );
  }
}
