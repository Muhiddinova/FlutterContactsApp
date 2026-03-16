import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../custom_widgets/custom_textfield.dart';
import '../custom_widgets/custom_buttons.dart';
import '../model/contact_model.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';

class EditContactPage extends StatefulWidget {
  final ContactModel contact;
  final int index;

  const EditContactPage({
    super.key,
    required this.contact,
    required this.index,
  });

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    phoneController = TextEditingController(text: widget.contact.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _updateContact() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name and phone cannot be empty")),
      );
      return;
    }

    final updatedContact = ContactModel(
      name: nameController.text,
      phone: phoneController.text,
      image: widget.contact.image,
    );

    context.read<HomeBloc>().add(
      UpdateContactEvent(widget.index, updatedContact),
    );

    Navigator.pop(context, updatedContact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/images/edit.png"),
              height: 140,
            ),
            const SizedBox(height: 60),
            CustomTextField(
              controller: nameController,
              hintText: 'Name',
              obscureText: false,
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.grey),
                onPressed: () => nameController.clear(),
              ),
            ),
            const SizedBox(height: 24),
            CustomTextField(
              controller: phoneController,
              hintText: 'Phone number',
              isPhone: true,
              obscureText: false,
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.grey),
                onPressed: () => phoneController.clear(),
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: "Update",
              onTap: _updateContact,
            ),
          ],
        ),
      ),
    );
  }
}
