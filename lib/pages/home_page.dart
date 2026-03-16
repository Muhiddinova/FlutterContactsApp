import 'package:contact/blocs/home/home_bloc.dart';
import 'package:contact/blocs/home/home_event.dart';
import 'package:contact/blocs/home/home_state.dart';
import 'package:contact/pages/login_page.dart';
import 'package:contact/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dialog/logout_dialog.dart';
import '../pref/contact_repository.dart';
import '../pref/db_helper.dart';
import 'add_contact_page.dart';
import 'contact_item.dart';
import 'edit_contact_page.dart';
import '../pref/contact_storage.dart';
import '../model/contact_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<ContactRepository>(context);
    return BlocProvider(
      create: (_) => HomeBloc(repo)..add(LoadHomeData()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeLoggedOut) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
            );
          }
          if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("${state.username}'s contacts"),
                actions: [
                  IconButton(
                    icon: Image.asset("assets/images/log_out.png"),
                    onPressed: () {
                      showLogoutDialog(
                        context: context,
                        onLogout: () {
                          context.read<HomeBloc>().add(LogoutEvent());
                        },
                        onRegister: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterPage()),
                          );
                        },
                      );

                    },
                  ),
                ],
              ),
              body: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];

                  return ContactItem(
                    contact: contact,
                    onDelete: () {
                      context.read<HomeBloc>().add(DeleteContactEvent(index));
                    },
                    onUpdate: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<HomeBloc>(),
                            child: EditContactPage(
                              contact: contact,
                              index: index,
                            ),
                          ),
                        ),
                      );

                      if (result != null && result is ContactModel) {
                        context.read<HomeBloc>().add(UpdateContactEvent(index, result));
                      }
                    },
                  );
                },
              ),
              floatingActionButton: GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<HomeBloc>(),
                        child: AddContactPage(),
                      ),
                    ),
                  );

                  if (result != null && result is ContactModel) {
                    context.read<HomeBloc>().add(AddContactEvent(result));
                  }
                },
                child: Image.asset(
                  "assets/images/icon_plus.png",
                  width: 60,
                  height: 60,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
