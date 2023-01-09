part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
    this.user = Profil.empty,
  });

  const AppState.authenticated(Profil user)
      : this._(status: AppStatus.authenticated, user: user);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final dynamic user;

  @override
  List<Object> get props => [status];
}
