import 'package:flutter/material.dart';

class FavouritesList extends StatelessWidget {
  const FavouritesList({super.key});

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
