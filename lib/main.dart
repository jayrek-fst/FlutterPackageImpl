import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_firebase_app/sign_up_screen.dart';
import 'package:standalone_pkg/domain/repository/firebase_register_repository_impl.dart';
import 'package:standalone_pkg/domain/usecase/register_usecase.dart';
import 'package:standalone_pkg/presentation/register_bloc/register_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => FirebaseRegisterRepositoryImpl()),
          RepositoryProvider(
              create: (context) =>
                  RegisterUseCase(FirebaseRegisterRepositoryImpl()))
        ],
        child: BlocProvider(
            create: (context) =>
                RegisterBloc(RegisterUseCase(FirebaseRegisterRepositoryImpl())),
            child: MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(primarySwatch: Colors.blue),
                home: const SignUpScreen())));
  }
}
