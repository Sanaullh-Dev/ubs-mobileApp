import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:ubs/pages/selling/P3_price/sale_final_page.dart';
import 'package:ubs/pages/selling/widgets/next_btn.dart';
import 'package:ubs/pages/selling/P2_image_Picker/widget/photo_tile.dart';
import 'package:ubs/pages/selling/P2_image_Picker/widget/select_image_silder.dart';
import 'package:ubs/utils/constants.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<Medium>? _mediaImg;
  bool _loading = true;
  ImageProvider? selImg;
  List<String> pathList = [];
  List<Medium> mediumList = [];

  @override
  void initState() {
    initAsync();
    super.initState();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);

      Album _allAlbum =
          albums.where((element) => element.name == "Camera").first;
      MediaPage mediaPage = await _allAlbum.listMedia();
      List<Medium> mediaList = mediaPage.items;

      setState(() {
        _mediaImg = mediaList;
        //     .where((medium) => medium.mediumType == MediumType.image)
        //     .toList();
        _loading = false;
      });
    }
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
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
                  child: pathList.isNotEmpty
                      ? SelectImageSlider(
                          imgList: pathList, mediumList: mediumList)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/assets/images/gallery.png",
                              height: 150,
                              width: 150,
                            ),
                            Text("Upload your images")
                          ],
                        ),
                ),
                _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(5),
                          child: AlignedGridView.count(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,
                              itemCount: _mediaImg!.length,
                              itemBuilder: (context, int index) {
                                return PhotoTile(
                                  mediaImg: _mediaImg![index],
                                  selectIndex:
                                      mediumList.indexOf(_mediaImg![index]),
                                  size: size,
                                  onpress: () async {
                                    if (pathList.length < 5) {
                                      File list = await PhotoGallery.getFile(
                                          mediumId: _mediaImg![index].id);
                                      if (list != null) {
                                        setState(() {
                                          mediumList.add(_mediaImg![index]);
                                          pathList.add(list.path.toString());
                                        });
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "You reached the image limit",
                                          style: snackbarTextStyle,
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                );
                              }),
                        ),
                      ),
                const SizedBox(height: 70)
              ],
            ),
            NextButton(
              onPress: () {
                if (pathList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Minium 1 Image required",
                      style: snackbarTextStyle,
                    ),
                    duration: const Duration(seconds: 2),
                  ));
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SaleFinalPage(),
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
                              