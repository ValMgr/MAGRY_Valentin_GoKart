import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_kart/app/repository/auth_repository.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/logo/round/152.png'),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign in to Go Kart',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const SizedBox(height: 40),
              _emailInput(_emailController),
              const SizedBox(height: 10),
              _passwordInput(_passwordController),
              const SizedBox(height: 20),
              _signInButton(
                context,
                _emailController,
                _passwordController,
              ),
              const SizedBox(height: 20),
              _signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }
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

Widget _signInButton(
  BuildContext context,
  TextEditingController email,
  TextEditingController password,
) {
  return ElevatedButton(
    onPressed: () async {
      try {
        await GetIt.I
            .get<AuthRepository>()
            .signInEmailAndPassword(email.text, password.text);
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    },
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
    ),
    child: const Text('Sign in'),
  );
}

Widget _signUpButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      Navigator.pushNamed(context, '/sign-up');
    },
    child: const Text('New ? Sign up \u2192'),
  );
}
