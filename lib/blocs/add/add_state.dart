

import '../../model/contact_model.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactError extends ContactState {
  final String message;

  ContactError(this.message);
}

class ContactSuccess extends ContactState {
  final ContactModel contact;

  ContactSuccess(this.contact);
}
class ContactLoaded extends ContactState {
  final List<ContactModel> contacts;
  ContactLoaded({required this.contacts});
}
class ContactUpdated extends ContactState {
  final ContactModel updatedContact;
  final int index;

  ContactUpdated({
    required this.updatedContact,
    required this.index,
  });
}
