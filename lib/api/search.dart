import 'package:myapp/domain/info.dart';
import 'package:dio/dio.dart';

class InfoApi {
  final dio = Dio();
  String baseUrl = 'https://brasilapi.com.br/api';

  Future<Info> findByCnpj(String cnpj) async {
    final response = await dio.get('$baseUrl/cnpj/v1/$cnpj');

    Info distribuidor = Info.fromJson(response.data);
    return distribuidor;
  }
}