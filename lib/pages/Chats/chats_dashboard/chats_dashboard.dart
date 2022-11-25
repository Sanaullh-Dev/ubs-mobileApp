import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/model/user_login.dart';
import 'package:ubs/pages/chats/chats_dashboard/tabs/chats_all.dart';
import 'package:ubs/pages/chats/chats_dashboard/tabs/chats_buy.dart';
import 'package:ubs/pages/chats/chats_dashboard/tabs/chats_sale.dart';
import 'package:ubs/pages/chats/controller/chats_controller.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';


class ChatsDashboard extends StatefulWidget {
  final UserLogin userLogin;
  const ChatsDashboard({super.key, required this.userLogin});

  @override
  State<ChatsDashboard> createState() => _ChatsDashboardState();
}

class _ChatsDashboardState extends State<ChatsDashboard>
    with SingleTickerProviderStateMixin {
  final ChatsController chatsController = Get.find<ChatsController>();
  
  @override
  void initState() {
    super.initState();
    if (chatsController.chatsRooms.value.isEmpty) {
      chatsController.getChatsRoomsList(widget.userLogin.userId);
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
                  automaticallyImplyLeading: false,
                  title: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("Chats", style: heading2InBold)),
                ),
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
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
              ChatsRoomAll(userLogin: widget.userLogin),
              ChatsRoomBuy(userLogin: widget.userLogin),
              ChatsRoomSale(userLogin: widget.userLogin),

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
