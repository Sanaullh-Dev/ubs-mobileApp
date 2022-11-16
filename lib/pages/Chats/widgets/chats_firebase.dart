import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/model/users_data.dart';
import 'package:ubs/pages/accounts/profile_page.dart/user_profile.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/pages/chats/widgets/chats_ListTiles.dart';
import 'package:ubs/pages/chats/widgets/filters_btn.dart';
import 'package:ubs/services/remote_services.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartFirebase1 extends StatefulWidget {
  final UserLogin userLogin;
  const ChartFirebase1({super.key, required this.userLogin});

  @override
  State<ChartFirebase1> createState() => _ChartFirebase1State();
}

class _ChartFirebase1State extends State<ChartFirebase1> {
  final dashboard chatsController = Get.find<dashboard>();

  @override
  void initState() {
    super.initState();
  }

  String getAdsUser(List<dynamic> users) {
    if (users[0] == widget.userLogin.userId) {
      return users[1];
    }
    return users[1];
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    return Obx(() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4, left: 15),
                child: Text(
                  "Quick Filters",
                  style:
                      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
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
                  stream: chatsController.chatsRoom.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          String userName = getAdsUser( data['chatsUser']);
                          // return ChatsListTitle(chatData: ,);
                          return ListTile(title: Text(data['adsPostUsers']));
                        },
                      );
                    }
                    return const Center(child: Text("Data not"));

                    // return ListView(
                    //   shrinkWrap: true,
                    //   children:
                    //       snapshot.data!.docs.map((DocumentSnapshot document) {
                    //     Map<String, dynamic> data =
                    //         document.data()! as Map<String, dynamic>;
                    //     return ListTile(
                    //       title: Text(data['name']),
                    //     );
                    //   }).toList(),
                    // );
                  }),
            ],
          ),
        ));
  }
}
