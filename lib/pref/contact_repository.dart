import 'package:hive/hive.dart';
import '../model/contact_model.dart';

class ContactRepository {
  final Box<ContactModel> _box = Hive.box<ContactModel>("contactsBox");

  Future<List<ContactModel>> getContacts() async {
    return _box.values.toList();
  }

  Future<ContactModel> addContact(ContactModel contact) async {
    await _box.add(contact);
    return contact;
  }

  Future<void> updateContact(int index, ContactModel contact) async {
    await _box.putAt(index, contact);
  }

  Future<void> deleteContact(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clearContacts() async {
    await _box.clear();
  }
}
