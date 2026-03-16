import 'package:contact/blocs/register/register_bloc.dart';
import 'package:contact/blocs/register/register_event.dart';
import 'package:contact/blocs/register/register_state.dart';
import 'package:contact/custom_widgets/custom_textfield.dart';
import 'package:contact/pref/contact_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widgets/custom_buttons.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/save.png"),
                height: 130,
                width: 140,
              ),
              const SizedBox(height: 60),

              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: usernameController,
                    errorText: state.showNameError
                        ? "Name is required"
                        : null,
                    hintText: 'Username',
                    obscureText: false,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        usernameController.clear();
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// PASSWORD
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    errorText: state.showPasswordError
                        ? state.passwordErrorText
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
                            .read<RegisterBloc>()
                            .add(
                            ToggleRegisterPasswordVisibility());
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              /// CONFIRM PASSWORD
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: confirmController,
                    hintText: 'Confirm Password',
                    obscureText: state.obscure,
                    errorText: state.showPasswordError
                        ? state.passwordErrorText
                        : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        context
                            .read<RegisterBloc>()
                            .add(
                            ToggleRegisterPasswordVisibility());
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 50),

              /// REGISTER BUTTON
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) async {
                  if (!state.isLoading &&
                      !state.showNameError &&
                      !state.showPasswordError) {
                    await ContactStorage.saveLogin(
                        usernameController.text.trim());

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: state.isLoading
                        ? "Loading..."
                        : "Register",
                    onTap: () {
                      context.read<RegisterBloc>().add(
                        RegisterSubmitted(
                          username:
                          usernameController.text.trim(),
                          password:
                          passwordController.text.trim(),
                          confirmPassword:
                          confirmController.text.trim(),
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
                  Text("Do you have an account? "),
                  Text(
                    " Log in",
                    style:
                    TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
