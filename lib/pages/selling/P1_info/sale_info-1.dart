import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/pages/selling/widgets/next_btn.dart';
import 'package:ubs/pages/selling/P2_image_Picker/image_picker_page.dart';
import 'package:ubs/sharing_widget/widget_fun.dart';
import 'package:ubs/utils/constants.dart';
import 'package:ubs/utils/text_style.dart';

class SaleInfo1 extends StatefulWidget {
  const SaleInfo1({Key? key}) : super(key: key);

  @override
  State<SaleInfo1> createState() => _SaleInfo1State();
}

class _SaleInfo1State extends State<SaleInfo1> {
  final _formKey = GlobalKey<FormState>();
  final _brandName = TextEditingController();
  final _title = TextEditingController();
  final _description = TextEditingController();
  SellingController sellingController = Get.find<SellingController>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Filled some details",
            style: heading3,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_outlined)),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      addVerticalSpace(10),
                      // Fot Brand name selection Text filed
                      TextFormField(
                        controller: _brandName,
                        decoration: const InputDecoration(
                            labelText: "Brand *",
                            labelStyle: TextStyle(fontSize: 15),
                            contentPadding: EdgeInsets.symmetric(vertical: 2)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 2) {
                            return 'minimum length of 2 characters is required';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          color: COLOR_LIGHT_BLACK,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      addVerticalSpace(25),
                      // Fot Title Text filed
                      TextFormField(
                        controller: _title,
                        decoration: const InputDecoration(
                          labelText: "Ad Title *",
                          labelStyle: TextStyle(fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(vertical: 2),
                        ),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return 'minimum length of 5 characters is required';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          color: COLOR_LIGHT_BLACK,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      addVerticalSpace(8),
                      Text(
                        "Mention the key features of your item(e.g. brand , model, age, type)",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      addVerticalSpace(25),
                      // -------------- For Description of selling -----
                      TextFormField(
                        controller: _description,
                        decoration: const InputDecoration(
                            labelText: "Describe what you are selling *",
                            labelStyle: TextStyle(fontSize: 15),
                            contentPadding: EdgeInsets.symmetric(vertical: 2)),
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        minLines: 1,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10) {
                            return 'minimum length of 10 characters is required';
                          } else if (value.length > 150) {
                            return 'You can write maximum 150 characters in Description';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          color: COLOR_LIGHT_BLACK,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      addVerticalSpace(8),
                      Text(
                        "Mention the key features of your item(e.g. brand , model, age, type)",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[700],
                        ),
                      ),
                      addVerticalSpace(80),
                      
                    ],
                  ),
                ),
              ),
              NextButton(
                  labelText: "Next",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      sellingController.sellingPost.value.pBrand =
                          _brandName.text;
                      sellingController.sellingPost.value.pTitle = _title.text;
                      sellingController.sellingPost.value.pDescribe =
                          _description.text;
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => ImagePickPage()),
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 400),
                            childCurrent: widget,
                            child: const ImagePickerPage()),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}


// Fot Brand name selection Text filed
  // TextFormField(
  //   controller: _brandName,
  //   readOnly: true,
  //   onEditingComplete: () {
  //     FocusScope.of(context).unfocus();
  //   },
  //   decoration: const InputDecoration(
  //       labelText: "Brand *",
  //       labelStyle: TextStyle(fontSize: 15),
  //       contentPadding: EdgeInsets.symmetric(vertical: 2)),
  //   keyboardType: TextInputType.name,
  //   validator: (value) {
  //     if (value == null || value.isEmpty || value == "") {
  //       return 'Select Brand of Selling';
  //     }
  //     return null;
  //   },
  //   onTap: () async {
  //     var selectBrand = await DialogPicker(context, size);
  //     if (selectBrand != "") {
  //       setState(() {
  //         _brandName.value =
  //             TextEditingValue(text: selectBrand);
  //       });
  //     }
  //   },
  //   style: const TextStyle(
  //     color: COLOR_LIGHT_BLACK,
  //     fontWeight: FontWeight.w400,
  //     fontSize: 16,
  //   ),
  // ),
                        