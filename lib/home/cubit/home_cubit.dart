import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changePage(int page, String pageName) {
    emit(state.copyWith(currentPage: page, pageName: pageName));
  }
}
