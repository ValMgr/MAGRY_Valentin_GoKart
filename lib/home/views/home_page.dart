// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/circuits/list/cubit/circuits_cubit.dart';
import 'package:go_kart/home/home.dart';
import 'package:go_kart/profile/cubit/profile_cubit.dart';
import 'package:go_kart/sessions/sessions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: GoKartAppBar.appBar(
          'Kirac',
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<AppBloc>().add(const AppLogoutRequested()),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(currentIndex: state.currentPage),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<ListSessionsCubit>(
              create: (context) => ListSessionsCubit()..getSessionsList(),
            ),
            BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit(context.read<AppBloc>().state.user!.id)..getProfile(),
            ),
            BlocProvider<SessionOverviewCubit>(
              create: (context) => SessionOverviewCubit()..getLastSession(),
            ),
            BlocProvider<CircuitsCubit>(
              create: (context) => CircuitsCubit()..getCircuits(),
            ),
          ],
          child: const HomeRouter(),
        ),
      ),
    );
  }
}
