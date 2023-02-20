import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/home/home.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<AppBloc>().state.isAdmin;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.read<HomeCubit>().changePage(index),
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.flag_rounded),
          label: 'Session',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart_sharp),
          label: 'Progression',
        ),
        if (isAdmin)
          const BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: 'Circuits',
          ),
      ],
    );
  }
}
