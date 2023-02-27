import 'package:flutter/material.dart';

class CreateSessionPage extends StatelessWidget {
  const CreateSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Session'),
      ),
      body: const Center(
        child: Text('Create Session'),
      ),
    );
  }
}
