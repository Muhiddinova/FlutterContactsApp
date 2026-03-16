import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/contact_model.dart';
import '../../pref/contact_repository.dart';
import '../../pref/contact_storage.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ContactRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<AddContactEvent>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final username = await ContactStorage.getUsername();
    final contacts = await repository.getContacts();

    emit(state.copyWith(
      username: username ?? "",
      contacts: contacts,
      isLoading: false,
    ));
  }

  Future<void> _onAddContact(
      AddContactEvent event, Emitter<HomeState> emit) async {
    if (event.contact.name.isEmpty || event.contact.phone.isEmpty) {
      emit(ContactError("Name and phone fields cannot be empty"));
      return;
    }

    emit(state.copyWith(isLoading: true));

    final newContact = await repository.addContact(event.contact);

    emit(state.copyWith(
      contacts: [...state.contacts, newContact],
      isLoading: false,
    ));
  }

  Future<void> _onUpdateContact(
      UpdateContactEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    await repository.updateContact(event.index, event.updatedContact);

    final updatedList = List<ContactModel>.from(state.contacts);
    updatedList[event.index] = event.updatedContact;

    emit(state.copyWith(
      contacts: updatedList,
      isLoading: false,
    ));
  }

  Future<void> _onDeleteContact(
      DeleteContactEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    await repository.deleteContact(event.index);

    final updatedList = List<ContactModel>.from(state.contacts)
      ..removeAt(event.index);

    emit(state.copyWith(
      contacts: updatedList,
      isLoading: false,
    ));
  }

  Future<void> _onLogout(
      LogoutEvent event, Emitter<HomeState> emit) async {
    await repository.clearContacts();
    emit(HomeLoggedOut());
  }
}
