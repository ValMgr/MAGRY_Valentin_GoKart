part of 'single_session_cubit.dart';

enum SingleSessionStatus { initial, loading, success, failure, deleted }

class SingleSessionState extends Equatable {
  const SingleSessionState({
    required this.session,
    this.status = SingleSessionStatus.initial,
  });

  final Session session;
  final SingleSessionStatus status;

  SingleSessionState copyWith({
    Session? session,
    SingleSessionStatus? status,
  }) {
    return SingleSessionState(
      status: status ?? this.status,
      session: session ?? this.session,
    );
  }

  @override
  List<Object> get props => [session, status];
}
