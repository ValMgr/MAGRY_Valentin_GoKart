// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:go_kart/home/views/home_page.dart';
import 'package:go_kart/login/views/login_page.dart';
import 'package:go_kart/sign_in/views/sign_in_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/sign-in': (context) => const SignInPage(),
        });
  }
}
