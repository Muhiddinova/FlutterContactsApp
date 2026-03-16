import 'package:flutter/material.dart';

import '../dialog/delete_dialog.dart';
import '../model/contact_model.dart';

class ContactItem extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ContactItem({
    super.key,
    required this.contact,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: contact.image.startsWith('http')
            ? NetworkImage(contact.image) as ImageProvider
            : AssetImage(contact.image),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == "update") {
            onUpdate();
          }
          if (value == "delete") {
            showDeleteDialog(
              context: context,
              name: contact.name,
              onDelete: onDelete,
            );

          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: "update",
            child: Text("Update"),
          ),
          PopupMenuItem(
            value: "delete",
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
