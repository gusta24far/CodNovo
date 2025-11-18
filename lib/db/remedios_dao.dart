import 'package:myapp/db/db_helper.dart';
import 'package:myapp/domain/remedio.dart';
import 'package:sqflite/sqflite.dart';

class RemediosDao {
  Future<List<Remedio>> listarRemedios() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM REMEDIO;';
    var result = await db.rawQuery(sql);

    List<Remedio> listaMedicamentos = [];

    for (var json in result) {
      Remedio medicamento = Remedio.fromJson(json);
      listaMedicamentos.add(medicamento);
    }
    
    return listaMedicamentos;
  }
}