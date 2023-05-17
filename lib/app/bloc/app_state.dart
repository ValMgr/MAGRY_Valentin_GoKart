part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    this.status = AppStatus.unauthenticated,
    this.user = User.empty,
    this.isAdmin = false,
  });

  const AppState.authenticated(User user, { bool isAdmin = false})
      : this._(status: AppStatus.authenticated, user: user, isAdmin: isAdmin);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User? user;
  final bool isAdmin;

  AppState copyWith({
    AppStatus? status,
    User? user,
    bool? isAdmin,
  }) {
    return AppState._(
      status: status ?? this.status,
      user: user ?? this.user,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object> get props => [status, isAdmin];
}
