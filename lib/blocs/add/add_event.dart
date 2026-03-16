abstract class ContactEvent {}

class AddContactEvent extends ContactEvent {
  final String name;
  final String phone;
  final String image;

  AddContactEvent({
    required this.name,
    required this.phone,
    required this.image,
  });
}
class UpdateContactEvent extends ContactEvent {
  final String name;
  final String phone;
  final String image;
  final int index;

  UpdateContactEvent({
    required this.name,
    required this.phone,
    required this.image,
    required this.index,
  });
}
