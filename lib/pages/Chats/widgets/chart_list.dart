import 'package:flutter/material.dart';
import 'package:ubs/model/cats_bord.dart';
import 'package:ubs/pages/Chats/widgets/chats_ListTiles.dart';
import 'package:ubs/pages/Chats/widgets/filters_btn.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';

class ChartList extends StatelessWidget {
  final List<ChatBoard> chatBoard;
  const ChartList({super.key, required this.chatBoard});

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 4, left: 15),
            child: Text(
              "Quick Filters",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Wrap(
              children: [
                const FiltersButtons(btnTitle: "All", isActive: true),
                addHorizontalSpace(10),
                const FiltersButtons(
                  btnTitle: "Meeting",
                  isActive: false,
                ),
                addHorizontalSpace(10),
                const FiltersButtons(
                  btnTitle: "Unread",
                  isActive: false,
                ),
                addHorizontalSpace(10),
                const FiltersButtons(
                  btnTitle: "Imports",
                  isActive: false,
                ),
              ],
            ),
          ),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: chatBoard.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatsListTitle(chatData: chatBoard[index],);
            },
          ),
        ],
      ),
    );
  }
}
