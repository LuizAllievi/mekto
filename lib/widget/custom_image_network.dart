import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utility/constants.dart';
import '../models/user.dart';

class CustomImageNetwork extends StatelessWidget {
  final String path;
  final double height;
  final double width;
  final BoxFit fit;

  final box = GetStorage();

  CustomImageNetwork(
      {Key? key,
      required this.path,
      required this.height,
      required this.width,
      required this.fit})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Image.network(
      MAIN_URL + "/api/" + path,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null, // Progress indicator.
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }
}
