import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_kart/auth/signup/cubit/signup_cubit.dart';
import 'package:quickalert/quickalert.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

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
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _EmailInput(),
                  const SizedBox(height: 4),
                  _PasswordInput(),
                  const SizedBox(height: 4),
                  _ConfirmedPasswordInput(),
                  const SizedBox(height: 4),
                  _SignUpButton(),
                ],
              ),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => TextField(
        key: const Key('signupForm_emailInput_textField'),
        onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          helperText: '',
          errorText: state.email.invalid ? 'invalid email' : null,
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => TextField(
        key: const Key('signupForm_passwordInput_textField'),
        onChanged: (password) =>
            context.read<SignUpCubit>().passwordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          helperText: '',
          errorText: state.password.invalid ? 'invalid password' : null,
        ),
      ),
    );
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) => TextField(
        key: const Key('signupForm_confirmedPasswordInput_textField'),
        onChanged: (confirmedPassword) => context
            .read<SignUpCubit>()
            .confirmedPasswordChanged(confirmedPassword),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          helperText: '',
          errorText:
              state.confirmedPassword.invalid ? 'Passwords do not match' : null,
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('signupForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: const Text('Sign up !'),
              );
      },
    );
  }
}
