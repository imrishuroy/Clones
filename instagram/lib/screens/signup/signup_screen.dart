import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';

import 'package:instagram/screens/signup/cubit/signup_cubit.dart';
import 'package:instagram/widgets/error_dialog.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  static const String routeName = '/signUp';

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => BlocProvider<SignupCubit>(
        create: (_) => SignupCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: SignUpScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      _formKey.currentState!.save();
      context.read<SignupCubit>().singUpWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (BuildContext context, SignupState state) {
          if (state.status == SignupStatus.error) {
            print(state);

            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ErrorDialog(content: state.failure!.message));
          }
        },
        builder: (BuildContext context, SignupState state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: state.status == SignupStatus.submitting
                  ? const CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text(
                                  'Instagram',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12.0),
                                TextFormField(
                                  onChanged: (String value) => context
                                      .read<SignupCubit>()
                                      .usernameChanged(value),
                                  decoration: const InputDecoration(
                                      hintText: 'Username'),
                                  validator: (String? value) =>
                                      value!.length < 3
                                          ? 'Username too short'
                                          : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  onChanged: (String value) => context
                                      .read<SignupCubit>()
                                      .emailChanged(value),
                                  decoration:
                                      const InputDecoration(hintText: 'Email'),
                                  validator: (String? value) =>
                                      !value!.contains('@')
                                          ? 'Please enter a valid email.'
                                          : null,
                                ),
                                const SizedBox(height: 16.0),
                                TextFormField(
                                  onChanged: (String value) => context
                                      .read<SignupCubit>()
                                      .passwordChanged(value),
                                  decoration: const InputDecoration(
                                      hintText: 'Password'),
                                  validator: (String? value) =>
                                      value!.length < 6
                                          ? 'Must be at least 6 characters'
                                          : null,
                                ),
                                const SizedBox(height: 28.0),
                                ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(elevation: 1.0),
                                  onPressed: () => _submit(context,
                                      state.status == SignupStatus.submitting),
                                  child: const Text('Sing Up'),
                                ),
                                // const SizedBox(height: 12.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 1.0,
                                    primary: Colors.grey[200],
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Have an account? Log In',
                                      style: TextStyle(color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
