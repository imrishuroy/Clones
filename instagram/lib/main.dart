import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram/blocs/auth/auth_bloc.dart';
import 'package:instagram/blocs/simple_bloc_observer.dart';
import 'package:instagram/config/custom_router.dart';
import 'package:instagram/repositories/auth/auth_repository.dart';
import 'package:instagram/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocOberser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Instagram',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: const AppBarTheme(
              brightness: Brightness.light,
              color: Colors.white,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            primarySwatch: Colors.blue,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
