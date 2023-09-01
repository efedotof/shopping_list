
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class buidImage extends StatelessWidget {
  const buidImage({
    super.key,
    required this.assetName,
    required this.width,
  });
  final String assetName;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/$assetName', width: width, repeat: true);
  }
}
