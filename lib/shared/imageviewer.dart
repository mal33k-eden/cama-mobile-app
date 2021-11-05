import 'package:flutter/material.dart';

class ImageViewerPop extends StatelessWidget {
  var path;
  bool isLocal;
  bool isAsset;
  ImageViewerPop(
      {Key? key,
      required this.path,
      required this.isLocal,
      required this.isAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(path);
    print('path');
    return Dialog(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
            image: (!isAsset)
                ? (isLocal)
                    ? DecorationImage(image: FileImage(path), fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage(path), fit: BoxFit.cover)
                : DecorationImage(image: AssetImage(path), fit: BoxFit.cover)),
      ),
    );
  }
}
