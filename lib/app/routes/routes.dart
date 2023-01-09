import 'package:flutter/widgets.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/home/home.dart';
import 'package:go_kart/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
