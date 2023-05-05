import 'dart:io';

import 'package:flutter/material.dart';

class AvatarUtils {
  static ImageProvider? display(String url) {
    if (url == '') return null;

    if (File(url).isAbsolute) {
      return Image.file(File(url)).image;
    }

    return Image.network(url).image;
  }
}
