import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';

class StateListPage extends StatefulWidget {
  const StateListPage({super.key});

  @override
  State<StateListPage> createState() => _StateListPageState();
}

class _StateListPageState extends State<StateListPage> {
  final String _listTitle = "Location";
  bool isTyping = false;
  TextEditingController searchInput = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        title: Text(_listTitle),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: TextField(
              controller: searchInput,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 16,
                  letterSpacing: 0.8),
              maxLines: 1,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isTyping = true;
                  });
                } else {
                  setState(() {
                    isTyping = false;
                  });
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                prefixIcon: const Icon(Icons.search),
                hintText: "Search city, area or neighborhood",
                suffixIcon: isTyping
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            searchInput.clear();
                            isTyping = false;
                          });
                        },
                      )
                    : const SizedBox(),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: COLOR_GREY),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
          ),
          // ------ States Tab view -----------
          Container(
            color: Colors.blueGrey[100],
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            child: Text("Choose State",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 15,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 2),
                  title: Text(
                    "State Name",
                    style: TextStyle(
                        color: Colors.blueGrey.shade900,
                        fontSize: 15,
                        letterSpacing: 0.9),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 2,
                  height: 0,
                );
              },
            ),
          ),

          // ------ Cities Tab view -----------
          // Column(
          //   children: [
          //     Container(
          //       color: Colors.blueGrey[200],
          //       child: const Text("Choose City"),
          //     ),
          //     Expanded(
          //       child: ListView.builder(
          //           itemCount: 50,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: const Text("Sate Name"),
          //               trailing: const Icon(Icons.arrow_forward_ios),
          //               onTap: () {},
          //             );
          //           }),
          //     ),
          //   ],
          // ),
          // // ------ Locality Tab view -----------
          // Column(
          //   children: [
          //     Container(
          //       color: Colors.blueGrey[200],
          //       child: const Text("Choose Locality"),
          //     ),
          //     Expanded(
          //       child: ListView.builder(
          //           itemCount: 50,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: const Text("Sate Name"),
          //               trailing: const Icon(Icons.arrow_forward_ios),
          //               onTap: () {},
          //             );
          //           }),
          //     ),
          //   ],
          // ),
        ],
      ),
    ));
  }
}
