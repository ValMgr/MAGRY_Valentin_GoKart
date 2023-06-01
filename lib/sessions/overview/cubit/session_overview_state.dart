part of 'session_overview_cubit.dart';

enum SessionOverviewStatus { initial, loading, success, failure }

class SessionOverviewState extends Equatable {
  const SessionOverviewState({
    required this.session,
    this.status = SessionOverviewStatus.initial,
  });

  final Session session;
  final SessionOverviewStatus status;

  SessionOverviewState copyWith({
    Session? session,
    SessionOverviewStatus? status,
  }) {
    return SessionOverviewState(
      session: session ?? this.session,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [session, status];
}
