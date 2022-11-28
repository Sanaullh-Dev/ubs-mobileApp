import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ubs/pages/login/controller/login_controller.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/sharing_widget/next_btn.dart';
import 'package:ubs/sharing_widget/massage_page.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';

class SaleFinalPage extends StatefulWidget {
  const SaleFinalPage({Key? key}) : super(key: key);

  @override
  State<SaleFinalPage> createState() => _SaleFinalPageState();
}

class _SaleFinalPageState extends State<SaleFinalPage> {
  final _formKey = GlobalKey<FormState>();
  final _price = TextEditingController();
  final _location = TextEditingController();
  SellingController sellingController = Get.find<SellingController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final LoginController loginController = Get.put(LoginController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Final Step of Sell",
            style: textTheme.headline5,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: Obx(() => sellingController.pageStatus.value != ""
            ? MessagePage(
                sellingController: sellingController,
                message: sellingController.pageStatus.value,
                size: size)
            : Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Form(
                        key: _formKey,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _price,
                              decoration: const InputDecoration(
                                labelText: "Price *",
                                labelStyle: TextStyle(fontSize: 15),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) < 150) {
                                  return 'Price has a minimum value of 150';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: lightBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            addVerticalSpace(15),
                            TextFormField(
                              controller: _location,
                              decoration: const InputDecoration(
                                labelText: "Location *",
                                labelStyle: TextStyle(fontSize: 15),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 2),
                              ),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select your location';
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: lightBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    NextButton(
                      enable: false,
                        labelText: "Post Now",
                        onPress: () async {
                          if (_formKey.currentState!.validate()) {
                            sellingController.sellingPost.value.pPrice =
                                int.parse(_price.text);
                            sellingController.sellingPost.value.pLocation =
                                _location.text;

                            await sellingController.insertPostAds(
                                sellingController.sellingPost.value);
                          }
                        })
                  ],
                ),
              )),
      ),
    );
  }
}
