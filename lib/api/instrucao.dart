import 'package:myapp/domain/instrucoes.dart';
import 'package:dio/dio.dart';

class InstrucaoApi {
  final dio = Dio();
  String baseUrl = 'https://my-json-server.typicode.com/gusta24far/FakeApi';

  Future<List<Instrucao>> findByNome(String nome) async {
    final response = await dio.get('$baseUrl/medicamentos');
    List<Instrucao> listaInstrucoes = [];
    if (response.statusCode == 200) {

      var result = response.data;
      
      for (var json in result) {
        Instrucao instrucao = Instrucao.fromJson(json);
        listaInstrucoes.add(instrucao);
      }
    }
    print(response.data);
    return listaInstrucoes;
  }
}