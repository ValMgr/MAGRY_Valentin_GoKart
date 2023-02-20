import 'package:flutter/material.dart';

class SessionOverview extends StatelessWidget {
  const SessionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SizedBox(
          height: 128,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Session Overview'),
            ],
          ),
        ),
      ),
    );
  }
}
