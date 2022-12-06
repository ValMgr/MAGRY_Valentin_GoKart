import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_kart/app/repository/auth_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Text(
                'Go Kart register form',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40),
              _emailInput(_emailController),
              const SizedBox(height: 10),
              _passwordInput(_passwordController),
              const SizedBox(height: 20),
              _signUpButton(
                context,
                _emailController.text,
                _passwordController.text,
              ),
              const SizedBox(height: 20),
              _backButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _signUpButton(BuildContext context, String email, String password) {
  return ElevatedButton(
    onPressed: () async {
      try {
        await GetIt.I
            .get<AuthRepository>()
            .signUpEmailAndPassword(email, password);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      }
    },
    child: const Text('Sign up'),
  );
}

Widget _emailInput(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(labelText: 'Email'),
  );
}

Widget _passwordInput(TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: const InputDecoration(labelText: 'Password'),
    obscureText: true,
  );
}

Widget _backButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text('Back'),
  );
}
