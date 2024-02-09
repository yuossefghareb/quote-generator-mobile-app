
import 'package:inter2grow_qoute_app/models/qoute_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static Database? _db;
  static const int _version = 6;
  static const String _tableName = 'favourite';

  static Future<void> initDB() async {
    if (_db != null) {
      print("dont found dp");
      return;
    } else {
      try {
        
        String path = await getDatabasesPath() + 'qoute.db';
        _db = await openDatabase(path, version: _version,
            onCreate: (Database _db, int version) async {
          await _db.execute(
            'CREATE TABLE $_tableName (h TEXT PRIMARY KEY, q TEXT, a TEXT)',
          );
        });
        print(
            "data base creted ##########-----------------------------------------");
      } catch (e) {
        print('error $e');
      }
    }
  }

  static Future<List<QuoteModel>> query() async {
    final List<Map<String, dynamic>> results = await _db!.query(_tableName);

    return List.generate(results.length, (index) {
      return QuoteModel(
          q: results[index]['q'],
          a: results[index]['a'],
          h: results[index]['h']);
    });
  }

  static Future<int> insert(QuoteModel? quoteModel) async {
    print(
        "data base inserted ##########-----------------------------------------");
    return await _db!.insert(_tableName, quoteModel!.toJson());
  }

  static Future<int> delete(String indx) async {
    return await _db!.delete(_tableName, where: 'h = ?', whereArgs: [indx]);
  }
}
