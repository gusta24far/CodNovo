class Remedio {
  late String nome;
  late String dose;
  late String descricao;
  late String idade;
  late String frequencia;

  Remedio({
    required this.nome,
    required this.dose,
    required this.descricao,
    required this.idade,
    required this.frequencia,
  });

  Remedio.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    dose = json['dose'];
    descricao = json['descricao'];
    idade = json['idade'];
    frequencia = json['frequencia'];
  }
}