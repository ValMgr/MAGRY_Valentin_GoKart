import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';
import 'package:go_kart/home/home.dart';
import 'package:go_kart/sessions/list_sessions/list_sessions.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.currentPage) {
          case 0:
            return const SessionPage();
          case 1:
            return const HomeContent();
          case 2:
            return const Text('@TODO - Charts page');
          case 3:
            return const CircuitsPage();
          default:
            return const HomeContent();
        }
      },
    );
  }
}
