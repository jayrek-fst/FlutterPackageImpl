import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:standalone_pkg/presentation/register_bloc/register_bloc.dart'
    as standalone_bloc;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: BlocConsumer<standalone_bloc.RegisterBloc,
            standalone_bloc.RegisterState>(listener: (context, state) {
          debugPrint('state: ${state.state}');
          if (state.state == standalone_bloc.State.registered) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Signed up successfully'),
                backgroundColor: Colors.green));
          }
          if (state.state == standalone_bloc.State.failed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.state.name), backgroundColor: Colors.red));
          }
        }, builder: (context, state) {
          return Stack(children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                          controller: emailController,
                          decoration:
                              const InputDecoration(hintText: 'Email Address')),
                      TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration:
                              const InputDecoration(hintText: 'Password')),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                debugPrint(
                                    '${emailController.text} : ${passwordController.text}');
                                context
                                    .read<standalone_bloc.RegisterBloc>()
                                    .add(standalone_bloc.StartRegisterEvent(
                                        emailController.text,
                                        passwordController.text));
                              },
                              child: const Text('Sign up')))
                    ])),
            if (state.state == standalone_bloc.State.loading)
              const Center(child: CircularProgressIndicator(color: Colors.red))
          ]);
        }));
  }
}
