import 'dart:async';
//import 'dart:indexed_db';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/entry.dart';
class DatabaseHelper {

	static DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();    // Singleton DatabaseHelper
	late Future<Database> _database = initializeDatabase();                // Singleton Database

	String entryTable = 'entry_table';
	String colId = 'id';
	String colName = 'name';
	String colYear = 'year';
	String colMonth = 'month';
	String colDay = 'day';
	String colTime = 'time';
	String colCategory = 'category';
	String colDetails = 'details';
	String colValue = 'value';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		_databaseHelper ??= DatabaseHelper._createInstance();
		return _databaseHelper;
	}

	Future<Database> get database async {
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = '${directory.path}entries.db';

		// Open/create the database at a given path
		var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $entryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, '
				'$colYear INTEGER, $colMonth INTEGER, $colDay INTEGER, $colTime INTEGER, $colCategory TEXT, $colDetails TEXT, '
				'$colValue INTEGER)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getEntryMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(entryTable, orderBy: '$colValue ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertEntry(Entry a) async {
		Database db = await this.database;
		var result = await db.insert(entryTable, a.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateEntry(Entry a) async {
		var db = await this.database;
		var result = await db.update(entryTable, a.toMap(), where: '$colId = ?', whereArgs: [a.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteEntry(int? id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $entryTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int?> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $entryTable');
		int? result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Entry>> getEntryList() async {

		var noteMapList = await getEntryMapList(); // Get 'Map List' from database
		int count = noteMapList.length;         // Count the number of map entries in db table

		List<Entry> entryList = <Entry>[];
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			entryList.add(Entry.fromMapObject(noteMapList[i]));
		}

		return entryList;
	}

}






