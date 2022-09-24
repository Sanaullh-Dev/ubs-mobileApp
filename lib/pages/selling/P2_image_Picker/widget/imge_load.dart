import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

Future<bool> promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

   Future<List<Medium>> getMedium() async {
    final albums = await PhotoGallery.listAlbums(mediumType: MediumType.image);
    final album = (albums.where((element) => element.name == "All").first);
    final MediaPage mediaPage = await album.listMedia();
    return mediaPage.items;
  }

