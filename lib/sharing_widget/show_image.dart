import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String? imageUrl;
  const ShowImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? "",
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset(
          "lib/assets/images/not_found.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class ShowUserPhoto extends StatelessWidget {
  final String imageUrl;
  const ShowUserPhoto({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.asset(
          "lib/assets/images/user.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


// CachedNetworkImage(
//       imageUrl: getLink(imageUrl),
//       imageBuilder: (context, imageProvider) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: imageProvider,
//               fit: BoxFit.cover,
//               // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
//               ),
//         ),
//       ),
//       // progressIndicatorBuilder: (context, url, downloadProgress) =>
//       //     CircularProgressIndicator(value: downloadProgress.progress),
//       placeholder: (context, url) => const CircularProgressIndicator(),
//       errorWidget: (context, url, error) => Padding(
//         padding: const EdgeInsets.all(25.0),
//         child:
//             Image.asset("lib/assets/images/not_found.png", fit: BoxFit.contain),
//       ),
//     )



