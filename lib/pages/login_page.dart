import 'package:contact/blocs/login/login_bloc.dart';
import 'package:contact/blocs/login/login_event.dart';
import 'package:contact/blocs/login/login_state.dart';
import 'package:contact/custom_widgets/custom_textfield.dart';
import 'package:contact/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widgets/custom_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/phone.png"),
                height: 164,
              ),
              const SizedBox(height: 60),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: usernameController,
                    errorText:
                    state.showNameError ? "Name is required" : null,
                    hintText: 'Username',
                    obscureText: false,
                    suffixIcon: IconButton(
                      icon:
                      const Icon(Icons.cancel, color: Colors.grey),
                      onPressed: () {
                        usernameController.clear();
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    errorText: state.showPasswordError
                        ? "Password is required"
                        : null,
                    obscureText: state.obscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(TogglePasswordVisibility());
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 50),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (!state.isLoading &&
                      !state.showNameError &&
                      !state.showPasswordError) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const RegisterPage(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: state.isLoading
                        ? "Loading..."
                        : "Log in",
                    onTap: () {
                      context.read<LoginBloc>().add(
                        LoginSubmitted(
                          username:
                          usernameController.text.trim(),
                          password:
                          passwordController.text.trim(),
                        ),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Don’t have an account yet?"),
                  Text(
                    " Sign up here",
                    style:
                    TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
