import 'package:contact/pages/home_page.dart';
import 'package:contact/pages/splash_page.dart';
import 'package:contact/pref/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:contact/model/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  await Hive.openBox<ContactModel>("contactsBox");
  final contactRepository = ContactRepository();
  runApp( RepositoryProvider.value(
    value: contactRepository,
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      home: const SplashPage(),
    );
  }
}
