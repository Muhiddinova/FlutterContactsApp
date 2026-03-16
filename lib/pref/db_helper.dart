import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/contact_model.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._init();
  static Database? _database;

  DbHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('contact.db');
    return _database!;
  }

  Future<Database> _initDb(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL,
        image TEXT
      )
    ''');
  }

  Future<int> insertContact(ContactModel contact) async {
    final db = await instance.database;
   return await db.insert('contacts', contact.toJson());
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await instance.database;

    final result = await db.query('contacts');

    return result.map((json) => ContactModel.fromJson(json)).toList();
  }
  Future<void> updateContact(ContactModel contact) async {
    final db = await instance.database;

    await db.update(
      'contacts',
      contact.toJson(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    final db = await instance.database;

    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<void> deleteAllContacts() async {
    final db = await instance.database;
    await db.delete('Contact'); // Contact jadvalini tozalaydi
  }

}
