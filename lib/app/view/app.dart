// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirac',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}


// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   final _supabase = Supabase.instance.client;
//   final _navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   void initState() {
//     super.initState();

//     _supabase.auth.onAuthStateChange.listen((data) {
//       if (data.event == AuthChangeEvent.signedIn) {
//         _navigatorKey.currentState?.pushReplacementNamed('/home');
//       } else if (data.event == AuthChangeEvent.signedOut) {
//         _navigatorKey.currentState?.pushReplacementNamed('/sign-in');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kirac',
//       theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
//       darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
//       navigatorKey: _navigatorKey,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const SplashScreenPage(),
//         '/home': (context) => const HomePage(),
//         '/sign-up': (context) => const SignUpPage(),
//         '/sign-in': (context) => const SignInPage(),
//       },
//     );
//   }
// }
