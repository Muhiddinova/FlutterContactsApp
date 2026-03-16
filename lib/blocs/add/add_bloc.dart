import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/contact_model.dart';
import '../../pref/contact_repository.dart';
import 'add_event.dart';
import 'add_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(ContactInitial()) {
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
  }

  Future<void> _onAddContact(
      AddContactEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    if (event.name.isEmpty) {
      emit(ContactError("Name is required"));
      return;
    }

    if (event.phone.isEmpty) {
      emit(ContactError("Phone is required"));
      return;
    }

    if (!event.phone.startsWith("+998")) {
      emit(ContactError("Phone must start with +998"));
      return;
    }

    final contact = ContactModel(
      name: event.name,
      phone: event.phone,
      image: event.image,
    );

    await repository.addContact(contact);

    emit(ContactSuccess(contact));
  }

  Future<void> _onUpdateContact(
      UpdateContactEvent event, Emitter<ContactState> emit) async {
    emit(ContactLoading());

    if (event.name.isEmpty) {
      emit(ContactError("Name is required"));
      return;
    }

    if (event.phone.isEmpty) {
      emit(ContactError("Phone is required"));
      return;
    }

    final updated = ContactModel(
      name: event.name,
      phone: event.phone,
      image: event.image,
    );

    await repository.updateContact(event.index, updated);

    emit(ContactSuccess(updated));
  }
}
