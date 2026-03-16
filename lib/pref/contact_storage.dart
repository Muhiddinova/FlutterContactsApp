import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/contact_model.dart';

class ContactStorage {
  static const String _key = "contacts";
  static const String _loginKey = "isLoggedIn";
  static const String _usernameKey = "username";

  /// SAVE CONTACTS
  static Future<void> saveContacts(List<ContactModel> contacts) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> jsonList =
    contacts.map((e) => jsonEncode(e.toMap())).toList();

    await prefs.setStringList(_key, jsonList);
  }

  /// LOAD CONTACTS
  static Future<List<ContactModel>> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList
        .map((e) => ContactModel.fromMap(jsonDecode(e)))
        .toList();
  }

  /// CLEAR CONTACTS
  static Future<void> clearContacts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  /// SAVE LOGIN STATE
  static Future<void> saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, true);
    await prefs.setString(_usernameKey, username);
  }

  /// CHECK LOGIN
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }

  /// GET USERNAME
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// LOG OUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, false);
    await prefs.remove(_usernameKey);
  }

}
