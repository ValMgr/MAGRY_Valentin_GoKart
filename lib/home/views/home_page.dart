import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Go Kart homepage',
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: const Text('Login'),
              ),
            ]),
      ),
    ));
  }
}
