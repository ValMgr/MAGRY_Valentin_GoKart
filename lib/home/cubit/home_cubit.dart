import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';
// part 'home_event.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

}

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc({
//     required ProfileRepository profileRepository,
//     required User currentUser,
//   })  : _profileRepository = profileRepository,
//         _currentUser = currentUser,
//         super(const HomeState()) {
//     on<ProfileRequested>(_onProfileRequested);
//     on<ProfileUpdated>(_onProfileUpdated);
//   }

//   final ProfileRepository _profileRepository;
//   final User _currentUser;

//   Future<void> _onProfileRequested(
//     ProfileRequested event,
//     Emitter<HomeState> emit,
//   ) async {
//     emit(state.copyWith(profilStatus: ProfileStatus.loading));

//     try {
//       final profile = await _profileRepository.getOneProfile(_currentUser.id);
//       emit(
//         state.copyWith(
//           profilStatus: ProfileStatus.success,
//           profile: profile,
//         ),
//       );
//     } catch (_) {
//       emit(state.copyWith(profilStatus: ProfileStatus.failure));
//     }
//   }

//   Future<void> _onProfileUpdated(
//     ProfileUpdated event,
//     Emitter<HomeState> emit,
//   ) async {
//     // await _profileRepository.updateProfile(event.profile);
//     emit(state.copyWith(profile: event.profile));
//   }
// }

