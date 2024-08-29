import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/api_quote_model.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? database;

  Future<void> initDB() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "mydb.db");

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query = """
          CREATE TABLE IF NOT EXISTS favouriteTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quote TEXT NOT NULL,
            author TEXT NOT NULL,
            image BLOB
          );
        """;
        db.execute(query);
      },
    );
  }

  //  Uint8List? image
  Future<void> addDb(
    String quote,
    String author,
  ) async {
    if (database != null) {
      String query = """
        INSERT INTO favouriteTable (quote, author, image)
        VALUES (?, ?, ?);
      """;
      await database!.rawInsert(query, [quote, author]);
    } else {
      initDB();
    }
  }

  Future<void> removeDB(int id) async {
    if (database != null) {
      String query = """
        DELETE FROM favouriteTable
        WHERE id = ?;
      """;
      await database!.rawDelete(query, [id]);
    } else {
      initDB();
    }
  }

  Future<void> removeAllDB() async {
    if (database != null) {
      String query = """
        DELETE FROM favouriteTable;
      """;
      await database!.rawDelete(query);
    } else {
      initDB();
    }
  }

  Future<List<ApiQuoteModel>> getAllData() async {
    if (database != null) {
      String query = """
      SELECT * FROM favouriteTable;
    """;
      List<Map<String, Object?>> result = await database!.rawQuery(query);
      return result.map((map) => ApiQuoteModel.fromMap(data: map)).toList();
    } else {
      initDB();
      return [];
    }
  }
}
