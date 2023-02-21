import 'package:flutter/material.dart';

class CircuitsList extends StatelessWidget {
  const CircuitsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: const Alignment(0, -1 / 3),
          child: Column(
            children: const [
              Text('Circuits list'),
            ],
          ),
        ),
      ),
    );
  }
}
