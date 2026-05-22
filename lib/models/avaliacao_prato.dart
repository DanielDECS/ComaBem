/// Representa a tabela `avaliacao_prato` do banco de dados coma_bem.
class AvaliacaoPrato {
  final int? idAvaliacao;
  final int idPrato;
  final int ranking;
  final String? recomendacao;

  AvaliacaoPrato({
    this.idAvaliacao,
    required this.idPrato,
    required this.ranking,
    this.recomendacao,
  }) {
    if (ranking < 1 || ranking > 5) {
      throw ArgumentError('O ranking deve estar entre 1 e 5.');
    }
  }

  /// Cria um objeto AvaliacaoPrato a partir de um registro retornado do banco.
  factory AvaliacaoPrato.fromMap(Map<String, dynamic> map) {
    return AvaliacaoPrato(
      idAvaliacao: map['id_avaliacao'] as int?,
      idPrato: map['id_prato'] as int,
      ranking: map['ranking'] as int,
      recomendacao: map['recomendacao'] as String?,
    );
  }

  /// Converte o objeto para um mapa com os mesmos nomes de campos da tabela.
  Map<String, dynamic> toMap() {
    return {
      'id_avaliacao': idAvaliacao,
      'id_prato': idPrato,
      'ranking': ranking,
      'recomendacao': recomendacao,
    };
  }
}
