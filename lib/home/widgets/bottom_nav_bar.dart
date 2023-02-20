import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/home/home.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => context.read<HomeCubit>().changePage(index),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.flag_rounded),
          label: 'Session',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.stacked_bar_chart_sharp),
          label: 'Progression',
        ),
      ],
    );
  }
}
