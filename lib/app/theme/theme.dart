import 'package:flutter/material.dart';

class GoKartButtons {
  static final elevatedButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    minimumSize: const Size(double.infinity, 50),
    backgroundColor: const Color.fromARGB(255, 255, 179, 0),
    foregroundColor: Colors.white,
    elevation: 2,
  );

}

class GoKartAppBar {
  static AppBar appBar(String title, {List<Widget>? actions}) => AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        elevation: 4,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: actions,
      );
}
