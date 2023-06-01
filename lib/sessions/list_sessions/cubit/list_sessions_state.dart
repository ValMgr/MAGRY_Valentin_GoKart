part of 'list_sessions_cubit.dart';

enum ListSessionsStatus { initial, loading, success, failure }

class ListSessionsState extends Equatable {

  const ListSessionsState({
    this.sessions = const [],
    this.status = ListSessionsStatus.initial,
    this.errorMessages,
  });

  final List<Session> sessions;
  final ListSessionsStatus status;
  final String? errorMessages;

  @override
  List<Object> get props => [sessions, status];

  ListSessionsState copyWith({
    List<Session>? sessions,
    ListSessionsStatus? status,
    String? errorMessages,
  }) {
    return ListSessionsState(
      sessions: sessions ?? this.sessions,
      status: status ?? this.status,
      errorMessages: errorMessages,
    );
  }
}
