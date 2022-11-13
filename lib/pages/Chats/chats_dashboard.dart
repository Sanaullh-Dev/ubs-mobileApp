import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ubs/model/cats_board.dart';
import 'package:ubs/pages/Chats/widgets/chats_firebase.dart';
import 'package:ubs/pages/chats/widgets/chart_list.dart';
import 'package:ubs/sharing_widget/sample_data.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class ChatsDashboard extends StatefulWidget {
  const ChatsDashboard({super.key});

  @override
  State<ChatsDashboard> createState() => _ChatsDashboardState();
}

class _ChatsDashboardState extends State<ChatsDashboard> {
  List<ChatBoard> chatBoard = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < chartBoardList.length; i++) {
      chatBoard.add(ChatBoard.fromJson(chartBoardList[i]));
    }
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
              const ChartFirebase(),
              // ChartList(chatBoard:chatBoard),
              // ChartList(chatBoard:chatBoard),
              ChartList(
                  chatBoard: chatBoard
                      .where((ChatBoard cb) => cb.postType == "Buy")
                      .toList()),
              ChartList(
                  chatBoard: chatBoard
                      .where((ChatBoard cb) => cb.postType == "Sale")
                      .toList()),
            ]),
          ),
        ),
      ),
    );
  }
}
