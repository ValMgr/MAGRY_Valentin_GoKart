import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'session_overview_state.dart';

class SessionOverviewCubit extends Cubit<SessionOverviewState> {
  SessionOverviewCubit() : super(const SessionOverviewState(session: Session.empty));

  final SessionRepository _sessionRepository = SessionRepository();

  Future<void> getLastSession() async {
    final lastSession = await _sessionRepository.getSessions().then((sessions) => sessions?.last);
    emit(state.copyWith(session: lastSession));
  }
}
