import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'list_sessions_state.dart';

class ListSessionsCubit extends Cubit<ListSessionsState> {
  ListSessionsCubit() : super(const ListSessionsState());

  final SessionRepository _sessionRepository = SessionRepository();

  Future<void> getSessionsList() async {
    emit(state.copyWith(status: ListSessionsStatus.loading));
    try {
      final sessions = await _sessionRepository.getSessions();
      emit(
        state.copyWith(
          sessions: sessions,
          status: ListSessionsStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ListSessionsStatus.failure,
          errorMessages: e.toString(),
        ),
      );
    }
  }

  void removeSession(int sessionId) {
    if (state.sessions.isEmpty) return;

    final sessions = state.sessions.where((session) => session.id != sessionId).toList();
    emit(state.copyWith(sessions: sessions));
  }

  void addSession(Session session) {
    emit(state.copyWith(sessions: [session, ...state.sessions]));
  }

}
