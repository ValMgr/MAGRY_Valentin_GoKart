import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'single_session_state.dart';

class SingleSessionCubit extends Cubit<SingleSessionState> {
  SingleSessionCubit() : super(const SingleSessionState(session: Session.empty));

  final SessionRepository _sessionRepository = SessionRepository();

  Future<void> getSession(int sessionId) async {
    try {
      final session = await _sessionRepository.findOneSession(sessionId);
      emit(state.copyWith(session: session, status: SingleSessionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SingleSessionStatus.failure));
    }
  }

  Future<void> deleteSession() async {
    try {
      await _sessionRepository.deleteSession(state.session.id!);
      emit(state.copyWith(status: SingleSessionStatus.deleted));
    } catch (e) {
      emit(state.copyWith(status: SingleSessionStatus.failure));
    }
  }
}
