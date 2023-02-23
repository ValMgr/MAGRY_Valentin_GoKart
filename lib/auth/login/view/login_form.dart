import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_kart/auth/login/login.dart';
import 'package:go_kart/auth/signup/signup.dart';
import 'package:quickalert/quickalert.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          QuickAlert.show(
            context: context,
            title: 'Error',
            text: state.errorMessage ?? 'Authentication Failure',
            type: QuickAlertType.error,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Image.asset('assets/logo/round/152.png'),
                ),
                const SizedBox(height: 40),
                Align(
                  child: Text(
                    'Sign in to Kirac',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Align(
                  child: Text(
                    'Welcome back!',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(height: 10),
                _EmailInput(),
                const SizedBox(height: 4),
                _PasswordInput(),
                const SizedBox(height: 4),
                _LoginButton(),
                const SizedBox(height: 4),
                _SignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => TextField(
        key: const Key('loginForm_emailInput_textField'),
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          helperText: '',
          errorText: state.email.invalid ? 'Invalid email' : null,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => TextField(
        key: const Key('loginForm_passwordInput_textField'),
        onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          helperText: '',
          errorText: state.password.invalid ? 'Invalid password' : null,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('Login'),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: const Text('Create account'),
    );
  }
}
