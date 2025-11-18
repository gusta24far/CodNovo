import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'remedio.db';

    String dbPath = join(path, dbName);
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );
    
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE REMEDIO (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT,
    dose TEXT,
    descricao TEXT,
    idade TEXT,
    frequencia TEXT
    );''';

    await db.execute(sql);

    sql =
        "INSERT INTO REMEDIO (nome, dose, descricao, idade, frequencia) VALUES ('Ibuprofeno', 'de 20 gotas (200mg) a 80 gotas (800mg)', 'O Ibuprofeno é um medicamento anti-inflamatório...', 'Uso Adulto', 'De 2 a 3 vezes por dia' );";
    await db.execute(sql);

    sql = "INSERT INTO REMEDIO (nome, dose, descricao, idade, frequencia) VALUES ('Paracetamol', '500mg', 'Analgésico e antitérmico', 'Uso Adulto', 'De 6 em 6 horas');";
    await db.execute(sql); 

  }
}