import 'package:flutter/material.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/widgets/chats_firebase.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsDashboard extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsDashboard({super.key, required this.userLogin});

  @override
  State<ChatsDashboard> createState() => _ChatsDashboardState();
}

class _ChatsDashboardState extends State<ChatsDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    // final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  title: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Chats", style: heading2InBold)),
                ),
                SliverAppBar(
                  pinned: true,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 58,
                    child: TabBar(
                        indicatorWeight: 6,
                        indicatorColor: COLOR_BLACK,
                        labelColor: COLOR_BLACK,
                        labelStyle: heading4,
                        labelPadding: const EdgeInsets.only(bottom: 8, top: 8),
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'Buying'),
                          Tab(text: 'Selling'),
                        ]),
                  ),
                )
              ];
            },
            body: TabBarView(children: [
              ChartFirebase1(userLogin: widget.userLogin),
              ChartFirebase1(userLogin: widget.userLogin),
              ChartFirebase1(userLogin: widget.userLogin),

              // ChartList(
              //     chatBoard: chatBoard
              //         .where((ChatBoard cb) => cb.postType == "Buy")
              //         .toList()),
              // ChartList(
              //     chatBoard: chatBoard
              //         .where((ChatBoard cb) => cb.postType == "Sale")
              //         .toList()),
            ]),
          ),
        ),
      ),
    );
  }
}
