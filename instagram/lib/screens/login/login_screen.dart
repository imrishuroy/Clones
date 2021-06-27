import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';
import 'package:instagram/screens/login/cubit/login_cubit.dart';
import 'package:instagram/screens/signup/signup_screen.dart';
import 'package:instagram/widgets/error_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  static Route<dynamic> route() {
    return PageRouteBuilder<dynamic>(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(),
      pageBuilder: (BuildContext context, _, __) => BlocProvider<LoginCubit>(
        create: (_) => LoginCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: LoginScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      _formKey.currentState!.save();
      context.read<LoginCubit>().loginWithEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (BuildContext context, LoginState state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      ErrorDialog(content: state.failure!.message));
            }
          },
          builder: (BuildContext context, LoginState state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: state.status == LoginStatus.submitting
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
                                        .read<LoginCubit>()
                                        .emailChanged(value),
                                    decoration: const InputDecoration(
                                        hintText: 'Email'),
                                    validator: (String? value) =>
                                        !value!.contains('@')
                                            ? 'Please enter a valid email.'
                                            : null,
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    onChanged: (String value) => context
                                        .read<LoginCubit>()
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
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1.0),
                                    onPressed: () => _submit(context,
                                        state.status == LoginStatus.submitting),
                                    child: const Text('Log In'),
                                  ),
                                  // const SizedBox(height: 12.0),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 1.0,
                                      primary: Colors.grey[200],
                                    ),
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName),
                                    child: const Text('No account? Sign Up',
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
      ),
    );
  }
}
