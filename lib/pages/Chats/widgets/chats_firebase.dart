import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubs/pages/chats/widgets/filters_btn.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartFirebase extends StatelessWidget {
  const ChartFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('Chats').snapshots();

    // final TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4, left: 15),
            child: Text(
              "Quick Filters",
              style: TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Wrap(
              children: [
                const FiltersButtons(btnTitle: "All", isActive: true),
                addHorizontalSpace(15),
                const FiltersButtons(
                  btnTitle: "Meeting",
                  isActive: false,
                ),
                addHorizontalSpace(15),
                const FiltersButtons(
                  btnTitle: "Unread",
                  isActive: false,
                ),
                addHorizontalSpace(15),
                const FiltersButtons(
                  btnTitle: "Imports",
                  isActive: false,
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                return ListView(
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                    );
                  }).toList(),
                );
              }),
        ],
      ),
    );
  }
}
