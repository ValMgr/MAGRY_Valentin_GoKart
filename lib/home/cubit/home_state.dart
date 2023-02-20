part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.currentPage = 1,
  });

  final int currentPage;

  @override
  List<Object> get props => [currentPage];

  HomeState copyWith({
    int? currentPage,
  }) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

// enum ProfileStatus { initial, loading, success, failure }

// class HomeState extends Equatable {
//   const HomeState({
//     this.profilStatus = ProfileStatus.initial,
//     this.profile = Profile.empty,
//   });

//   final ProfileStatus profilStatus;
//   final Profile profile;

//   @override
//   List<Object> get props => [profilStatus, profile];

//   HomeState copyWith({
//     ProfileStatus? profilStatus,
//     Profile? profile,
//   }) {
//     return HomeState(
//       profilStatus: profilStatus ?? this.profilStatus,
//       profile: profile ?? this.profile,
//     );
//   }
// }


