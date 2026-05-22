/// Representa a tabela `prato` do banco de dados coma_bem.
class Prato {
  final int? idPrato;
  final String nomePrato;
  final String? fotoPrato;
  final int idRestaurante;

  Prato({
    this.idPrato,
    required this.nomePrato,
    this.fotoPrato,
    required this.idRestaurante,
  });

  /// Cria um objeto Prato a partir de um registro retornado do banco.
  factory Prato.fromMap(Map<String, dynamic> map) {
    return Prato(
      idPrato: map['id_prato'] as int?,
      nomePrato: map['nome_prato'] as String,
      fotoPrato: map['foto_prato'] as String?,
      idRestaurante: map['id_restaurante'] as int,
    );
  }

  /// Converte o objeto para um mapa com os mesmos nomes de campos da tabela.
  Map<String, dynamic> toMap() {
    return {
      'id_prato': idPrato,
      'nome_prato': nomePrato,
      'foto_prato': fotoPrato,
      'id_restaurante': idRestaurante,
    };
  }
}
