class Info {
  late String cnpj;
  late String bairro;
  late String numero;
  late String municipio;
  late String logradouro;

  Info({
    required this.cnpj,
    required this.bairro,
    required this.numero,
    required this.municipio,
    required this.logradouro,
  });

  String get info => '$municipio, $bairro, $numero, $logradouro';

  Info.fromJson(Map<String, dynamic> json) {
    cnpj = json['cnpj'];
    bairro = json['bairro'];
    municipio = json['municipio']; 
    numero = json['numero'];
    logradouro = json['logradouro']; 
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnpj'] = cnpj;
    data['bairro'] = bairro;
    data['municipio'] = municipio; 
    data['numero'] = numero;
    data['logradouro'] = logradouro;
     
    return data;
  }
}