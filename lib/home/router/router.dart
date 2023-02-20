import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/home/home.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.currentPage) {
          case 0:
            return const Text('Session page');
          case 1:
            return const HomeContent();
          case 2:
            return const Text('Charts page');
          default:
            return const HomeContent();
        }
      },
    );
  }
}
