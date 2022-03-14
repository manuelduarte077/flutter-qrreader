import 'dart:io';

import 'package:path/path.dart';
import 'package:qr_scanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// Singleton DatabaseHelper
class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    //  Path de donde vamos a crear la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ScannDB.db");
    print(path);

    // Crear la base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Scans ("
          "id INTEGER PRIMARY KEY,"
          "tipo TEXT,"
          "valor TEXT"
          ")");
    });
  }

  // Crear Registro
  Future<int?> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db?.insert('Scans', nuevoScan.toJson());
    // Es el ID del ultimo registro insertado
    return res;
  }

  // Obtener un registro por ID
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);
    // Lista de registros
    return res!.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  // Obtener todos los registros
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db?.query('Scans');
    // Lista de registros
    return res!.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Obtener los scan por tipo
  Future<List<ScanModel>> getScansByType(String tipo) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'tipo = ?', whereArgs: [tipo]);
    // Lista de registros
    return res!.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  // Actualizar registro
  Future<int?> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db?.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  // Borrar registro
  Future<int?> deleteScan(int id) async {
    final db = await database;
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Borrar todos los registros
  Future<int?> deleteAll() async {
    final db = await database;
    final res = await db?.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
