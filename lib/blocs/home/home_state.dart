

import '../../model/contact_model.dart';

class HomeState {
  final List<ContactModel> contacts;
  final String username;
  final bool isLoading;

  const HomeState({
    this.contacts = const [],
    this.username = "",
    this.isLoading = false,
  });

  HomeState copyWith({
    List<ContactModel>? contacts,
    String? username,
    bool? isLoading,
  }) {
    return HomeState(
      contacts: contacts ?? this.contacts,
      username: username ?? this.username,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
class ContactError extends HomeState {
  final String message;

  ContactError(this.message): super(isLoading: false);
}
class ContactSuccess extends HomeState {
  final ContactModel contact;

  ContactSuccess(this.contact);
}
class HomeLoggedOut extends HomeState {
  HomeLoggedOut() : super(contacts: [], username: "", isLoading: false);}

