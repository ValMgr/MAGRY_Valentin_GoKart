import 'package:flutter/material.dart';
import 'package:go_kart/profile/profile.dart';
import 'package:go_kart/sessions/sessions.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            children: const [
              ProfileOveriew(),
              SizedBox(height: 32),
              SessionOverview(),
            ],
          ),
        ),
      ),
    );
  }
}
