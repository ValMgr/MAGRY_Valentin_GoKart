// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/bootstrap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _requiredEnvVars = [
  'SUPABASE_URL',
  'SUPABASE_ANON_KEY',
];

bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  if (!hasEnv) {
    throw Exception('Missing environment variables');
  }

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  final authenticationRepository = AuthenticationRepository();
  // await authenticationRepository.user.first;

  await bootstrap(
    () => App(authenticationRepository: authenticationRepository),
  );
}
