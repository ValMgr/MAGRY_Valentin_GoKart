// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:go_kart/app/color_schemes.g.dart';
import 'package:go_kart/app/view/home_page.dart';
import 'package:go_kart/app/view/splash_page.dart';
import 'package:go_kart/users/views/sign_in_page.dart';
import 'package:go_kart/users/views/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (data.event == AuthChangeEvent.signedOut) {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreenPage(),
        '/home': (context) => const HomePage(),
        '/sign-up': (context) => const SignUpPage(),
        '/sign-in': (context) => const SignInPage(),
      },
    );
  }
}
