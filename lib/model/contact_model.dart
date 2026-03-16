import 'package:hive/hive.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String image;

  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.image,
  });

  // SQL / SharedPreferences uchun
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      'name': name,
      'phone': phone,
      'image': image,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      image: map['image'],
    );
  }

  // Agar JSON ishlatsangiz
  Map<String, dynamic> toJson() => toMap();

  factory ContactModel.fromJson(Map<String, dynamic> json) =>
      ContactModel.fromMap(json);

  // copyWith
  ContactModel copyWith({
    int? id,
    String? name,
    String? phone,
    String? image,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }
}
