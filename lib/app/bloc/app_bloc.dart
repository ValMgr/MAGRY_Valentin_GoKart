import 'dart:async';
import 'dart:io';

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
      isUserAdmin();
    });
    isUserAdmin();
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) async {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event.user)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  Future<void> isUserAdmin() async {
    if (_authenticationRepository.currentUser.isEmpty) {
      return;
    }

    final isAdmin = await _authenticationRepository
        .isUserAdmin(_authenticationRepository.currentUser.id);

    // Wait for the state to be updated
    // @todo Find a better way to do this
    sleep(const Duration(milliseconds: 100));
    emit(state.copyWith(isAdmin: isAdmin));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
