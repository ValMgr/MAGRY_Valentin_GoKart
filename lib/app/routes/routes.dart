import 'package:flutter/widgets.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/auth/login/login.dart';
import 'package:go_kart/home/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
    // @TODO: Hoisted le bloc provider + ajouter le findOneProfile
    // BLocBuuilder qui listen les différents states
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
