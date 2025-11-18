class Instrucao {
  late String nome;
  late String dose;
  late String frequencia;

  Instrucao({
    required this.nome,
    required this.dose,
    required this.frequencia,
  });

  String get regra => '$dose, $frequencia';

  Instrucao.fromJson(Map<String, dynamic> json) {
    dose = json['dose'].toString();
    frequencia = json['frequencia'].toString();
    nome = json['nome'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dose'] = dose;
    data['vezes'] = frequencia;
    data['nome'] = nome;
     
    return data;
  }
}