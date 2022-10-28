import 'package:flutter/material.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile(
          title: Text("\$ 5,000"),
          subtitle: Text("New conduction "),
        );
      },
    );
  }
}
