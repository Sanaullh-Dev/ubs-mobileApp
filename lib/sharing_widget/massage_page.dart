import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/home/controller/home_controller.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/sharing_widget/primery_button.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class MessagePage extends StatelessWidget {
  final String message;
  final Size size;
  final SellingController sellingController;
  const MessagePage(
      {Key? key,
      required this.message,
      required this.size,
      required this.sellingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: COLOR_BLACK.withAlpha(150),
      child: Center(
        child: Container(
            width: size.width - size.width * 0.1,
            height: 250,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: message == "Loading"
                ? loadingBox()
                : messageBox(message, context)),
      ),
    );
  }

  Widget loadingBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        addVerticalSpace(25),
        const Text(
          "Loading",
          style: TextStyle(
            color: COLOR_BLACK,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        )
      ],
    );
  }

  Widget messageBox(String message, BuildContext context) {
    final HomeController homeCont = Get.find<HomeController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Icon(Icons.done_outline),
        SizedBox(
          height: 70,
          width: 70,
          child: Image.asset("lib/assets/images/ok.png"),
        ),
        addVerticalSpace(25),
        Text(
          message,
          style: const TextStyle(
            color: COLOR_BLACK,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        addVerticalSpace(25),
        PrimaryButton(
          onPress: () {
            sellingController.pageStatus.value = "";
            homeCont.fetchAds();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
          title: "Back To home",
        ),
      ],
    );
  }
}
