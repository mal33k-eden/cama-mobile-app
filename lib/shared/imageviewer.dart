import 'package:flutter/material.dart';

class ImageViewerPop extends StatelessWidget {
  var path;
  bool isLocal;
  ImageViewerPop({Key? key, required this.path, required this.isLocal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 700,
        height: 700,
        decoration: BoxDecoration(
            image: (isLocal)
                ? DecorationImage(image: FileImage(path), fit: BoxFit.cover)
                : DecorationImage(
                    image: NetworkImage(path), fit: BoxFit.cover)),
      ),
    );
  }
}
