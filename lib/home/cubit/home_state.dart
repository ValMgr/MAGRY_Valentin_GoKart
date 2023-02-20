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
