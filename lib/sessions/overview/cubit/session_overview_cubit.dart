import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  SessionOverviewCubit() : super(const SessionOverviewState(session: Session.empty));

  final SessionRepository _sessionRepository = SessionRepository();

  Future<void> getLastSession() async {
    try {
      emit(state.copyWith(status: SessionOverviewStatus.loading));

      final sessions = await _sessionRepository.getSessions();
      if (sessions != null && sessions.isNotEmpty) {
        final lastSession = sessions.last;
        emit(state.copyWith(session: lastSession, status: SessionOverviewStatus.success));
        return;
      }
      emit(state.copyWith(status: SessionOverviewStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SessionOverviewStatus.failure));
    }
  }
}
