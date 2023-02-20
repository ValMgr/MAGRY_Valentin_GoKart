import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        switch (value) {
          case 'settings':
            return null; // TODO: implement settings
          case 'logout':
            return context.read<AppBloc>().add(const AppLogoutRequested());
        }
      },
      itemBuilder: (_) => <PopupMenuEntry<String>>[
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: const [
              Icon(Icons.settings_rounded),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Row(
            children: const [
              Icon(Icons.logout_rounded),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
