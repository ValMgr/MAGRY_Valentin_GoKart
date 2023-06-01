import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';
part 'app_event.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = authenticationRepository.user.listen((user) {
      add(_AppUserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  Future<void> _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user, isAdmin: await isUserAdmin())
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  Future<bool> isUserAdmin() async {
    if (_authenticationRepository.currentUser.isEmpty) {
      return false;
    }

    return _authenticationRepository.isUserAdmin(_authenticationRepository.currentUser.id);
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
