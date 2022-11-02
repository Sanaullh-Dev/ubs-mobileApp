import 'package:flutter/material.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class MyAdsList extends StatelessWidget {
  const MyAdsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          // borderRadius: BorderRadius.circular(5),
          Container(
            // height: 150,
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(15, 10, 10, 10),
            padding: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black45,
                      offset: Offset(2, 2),
                      blurRadius: 4),
                  BoxShadow(
                      color: Colors.blueGrey[800]!,
                      offset: Offset(-6, 0),
                      blurRadius: 0)
                ]),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(6)),
                    color: Colors.blueGrey[100],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 18),
                      Text("Publish on 13 Oct 2022", style: cardTitle),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.more_horiz))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(
                          "lib/assets/images/user.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 400,
                              child: Text(
                                  "Product Title Name hear asd asd asdasdasd asdasd",
                                  style: messageLabel)),
                          const SizedBox(height: 5),
                          Text(
                            "5000",
                            style: heading5,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.remove_red_eye),
                              Text("  View : 2", style: btnText),
                              SizedBox(width: 15),
                              Text("|", style: btnText),
                              SizedBox(width: 15),
                              Icon(Icons.favorite),
                              Text("  favorite : 2", style: btnText),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                VerticalDivider(thickness: 5 , color: Colors.red,) ,
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
