

import '../../model/contact_model.dart';

abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class DeleteContactEvent extends HomeEvent {
  final int index;
  DeleteContactEvent(this.index);
}

class AddContactEvent extends HomeEvent {
  final ContactModel contact;
  AddContactEvent(this.contact);
}

class UpdateContactEvent extends HomeEvent {
  final int index;
  final ContactModel updatedContact;
  UpdateContactEvent(this.index, this.updatedContact);
}

class LogoutEvent extends HomeEvent {}
