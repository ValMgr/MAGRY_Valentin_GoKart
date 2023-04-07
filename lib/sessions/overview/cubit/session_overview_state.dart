part of 'session_overview_cubit.dart';

class SessionOverviewState extends Equatable {
  const SessionOverviewState({
    required this.session,
  });

  final Session session;

  SessionOverviewState copyWith({
    Session? session,
  }) {
    return SessionOverviewState(
      session: session ?? this.session,
    );
  }

  @override
  List<Object> get props => [session];
}
