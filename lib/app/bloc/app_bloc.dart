import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_state.dart';
part 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentProfil.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentProfil)
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = authenticationRepository.user.listen((user) {
      add(_AppUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<Profil> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      (event.user as Profil).isNotEmpty
          ? AppState.authenticated(event.user as Profil)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
