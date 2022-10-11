import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:ubs/pages/selling/P2_image_Picker/widget/imge_load.dart';
import 'package:ubs/pages/selling/P3_price_location/sale_final_page.dart';
import 'package:ubs/pages/selling/controller/selling_controller.dart';
import 'package:ubs/sharing_widget/next_btn.dart';
import 'package:ubs/pages/selling/P2_image_Picker/widget/photo_tile.dart';
import 'package:ubs/pages/selling/P2_image_Picker/widget/select_image_silder.dart';
import 'package:ubs/utils/constants.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  SellingController sellingController = Get.find<SellingController>();
  ImageProvider? selImg;
  List<String> selectedPath = [];
  List<String> loadPaths = [];
  List<Medium> mediumList = [];
  ScrollController scrollController = ScrollController();
  int count = 0;

  @override
  void initState() {
    initAsync();
    super.initState();
    scrollController = ScrollController()..addListener(handleScrolling);
  }

  @override
  void dispose() {
    scrollController.removeListener(handleScrolling);
    super.dispose();
  }

  void handleScrolling() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      getPathList();
    }
  }

  void getPathList() async {
    File imgFile;
    int _beforcount = count;

    if (count < mediumList.length) {
      // count = mediumList.length < count + 15 ? mediumList.length - 1 : count + 15;
      count = mediumList.length < count ? mediumList.length - 1 : count + 15;

      for (var i = _beforcount; i <= count; i++) {
        imgFile = await PhotoGallery.getFile(mediumId: mediumList[i].id);
        if (imgFile.existsSync()) {
          loadPaths.add(imgFile.path.toString());
        }
      }
      setState(() {});
    }
  }




  Future<void> initAsync() async {
    if (await promptPermissionSetting()) {
      mediumList = await getMedium();
      getPathList();
    }
  }

  addImages() {
    if (selectedPath.isNotEmpty) {
      sellingController.sellingPost.value.pImg1 = selectedPath[0];
    }
    if (selectedPath.length > 1) {
      sellingController.sellingPost.value.pImg2 = selectedPath[1];
    }
    if (selectedPath.length > 2) {
      sellingController.sellingPost.value.pImg3 = selectedPath[2];
    }
    if (selectedPath.length > 3) {
      sellingController.sellingPost.value.pImg4 = selectedPath[3];
    }
    if (selectedPath.length > 4) {
      sellingController.sellingPost.value.pImg5 = selectedPath[4];
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload your photos'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 250,
                  child: selectedPath.isNotEmpty
                      ? SelectImageSlider(imgList: selectedPath)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/images/gallery.png",
                              height: 150,
                              width: 150,
                            ),
                            const Text("Upload your images")
                          ],
                        ),
                ),
                loadPaths.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(5),
                          child: AlignedGridView.count(
                              controller: scrollController,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              crossAxisCount: 3,
                              itemCount: loadPaths.length,
                              itemBuilder: (context, int index) {
                                return PhotoTile(
                                  imgPath: loadPaths[index],
                                  selectIndex:
                                      selectedPath.indexOf(loadPaths[index]),
                                  size: size,
                                  onPress: () async {
                                    addImage(index);
                                  },
                                );
                              }),
                        ),
                      ),
                const SizedBox(height: 70)
              ],
            ),
            NextButton(
              enable: true,
              labelText: "Next",
              onPress: () {
                if (selectedPath.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Minium 1 Image required",
                      style: snackbarTextStyle,
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                } else {
                  addImages();
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.rightToLeftJoined,
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      childCurrent: widget,
                      child: const SaleFinalPage(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  addImage(int index) {
    var ck = selectedPath.indexOf(loadPaths[index]);
    if (ck >= 0) {
      setState(() {
        selectedPath.removeAt(ck);
      });
    } else {
      if (selectedPath.length < 5) {
        setState(() {
          selectedPath.add(loadPaths[index]);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "You reached the image limit",
            style: snackbarTextStyle,
          ),
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }
}

// return PhotoTile(
//   mediaImg: _mediaImg![index],
//   selectIndex:
//       mediumList.indexOf(_mediaImg![index]),
//   size: size,
//   onpress: () async {
//     if (pathList.length < 5) {
//       File list = await PhotoGallery.getFile(
//           mediumId: _mediaImg![index].id);
//       if (list != null) {
//         setState(() {
//           mediumList.add(_mediaImg![index]);
//           pathList.add(list.path.toString());
//         });
//       }
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(
//         content: Text(
//           "You reached the image limit",
//           style: snackbarTextStyle,
//         ),
//         duration: const Duration(seconds: 2),
//       ));
//     }
//   },
// );
