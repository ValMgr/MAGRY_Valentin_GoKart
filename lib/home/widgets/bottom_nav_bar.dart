import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/home/home.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final pageName = [
      'Session',
      'Home',
      'Progression',
      'Circuits',
    ];

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            context.read<HomeCubit>().changePage(index, pageName[index]);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.timer_rounded),
              label: pageName[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: pageName[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.show_chart_rounded),
              label: pageName[2],
            ),
            if (context.read<AppBloc>().state.isAdmin)
              BottomNavigationBarItem(
                icon: const Icon(Icons.all_inclusive_rounded),
                label: pageName[3],
              ),
          ],
        );
      },
    );
  }
}
