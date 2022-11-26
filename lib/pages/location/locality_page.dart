import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

class LocalityPage extends StatelessWidget {
  final String city;
  const LocalityPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    bool isTyping = false;
    // List<String> cities;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(city),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search city, area or neighborhood",
                suffixIcon: isTyping == true ? const Icon(Icons.close) : null,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ),
          Container(
            color: Colors.blueGrey[200],
            child: const Text("Chosse State"),
          ),
          Visibility(
            replacement: const CircularProgressIndicator(),
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text("Sate Name"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  );
                }),
          )
        ],
      ),
    ));
  }
}
