part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.currentPage = 1,
    this.pageName = 'Home',
  });

  final int currentPage;
  final String pageName;

  HomeState copyWith({
    int? currentPage,
    String? pageName,
  }) {
    return HomeState(
      currentPage: currentPage ?? this.currentPage,
      pageName: pageName ?? this.pageName,
    );
  }

  @override
  List<Object> get props => [currentPage, pageName];
}
