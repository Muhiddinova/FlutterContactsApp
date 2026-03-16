import 'package:contact/blocs/home/home_bloc.dart';
import 'package:contact/blocs/home/home_event.dart';
import 'package:contact/blocs/home/home_state.dart';
import 'package:contact/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_widgets/custom_buttons.dart';
import '../model/contact_model.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final List<String> images = [
    "https://randomuser.me/api/portraits/men/1.jpg",
    "https://randomuser.me/api/portraits/women/2.jpg",
    "assets/images/aka1.png",
    "assets/images/aka2.png",
    "assets/images/aka3.png",
  ];

  String? selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = images[0];
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(title: const Text("Add Contact")),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: selectedImage!.startsWith('http')
                          ? NetworkImage(selectedImage!)
                          : AssetImage(selectedImage!) as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final img = images[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = img;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedImage == img
                                    ? const Color(0xffEB5757)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: img.startsWith('http')
                                  ? NetworkImage(img)
                                  : AssetImage(img) as ImageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  CustomTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.grey),
                      onPressed: () {
                        nameController.clear();
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  CustomTextField(
                    controller: phoneController,
                    hintText: 'Phone number',
                    obscureText: false,
                    isPhone: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.grey),
                      onPressed: () {
                        phoneController.clear();
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                    CustomButton(
                      text: "Add",
                      onTap: () {
                        // ✅ 1. Name tekshiramiz
                        if (nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Ism kiritishingiz kerak")),
                          );
                          return;
                        }

                        // ✅ 2. Phone tekshiramiz
                        if (phoneController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Telefon raqam kiritishingiz kerak")),
                          );
                          return;
                        }

                        final contact = ContactModel(
                          id: null,
                          name: nameController.text.trim(),
                          phone: phoneController.text.trim(),
                          image: selectedImage!,
                        );

                        context.read<HomeBloc>().add(AddContactEvent(contact));

                        // faqat hammasi to'g'ri bo'lsa chiqadi
                        Navigator.pop(context);
                      },

                    ),
                ],
              ),
            ),
          );
        },
    );
  }
}
