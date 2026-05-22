/// Representa a tabela `restaurante` do banco de dados coma_bem.
class Restaurante {
  final int? idRestaurante;
  final String nome;
  final double? latitude;
  final double? longitude;
  final String? tipoCulinaria;

  Restaurante({
    this.idRestaurante,
    required this.nome,
    this.latitude,
    this.longitude,
    this.tipoCulinaria,
  });

  /// Cria um objeto Restaurante a partir de um registro retornado do banco.
  factory Restaurante.fromMap(Map<String, dynamic> map) {
    return Restaurante(
      idRestaurante: map['id_restaurante'] as int?,
      nome: map['nome'] as String,
      latitude: _toDouble(map['latitude']),
      longitude: _toDouble(map['longitude']),
      tipoCulinaria: map['tipo_culinaria'] as String?,
    );
  }

  /// Converte o objeto para um mapa com os mesmos nomes de campos da tabela.
  Map<String, dynamic> toMap() {
    return {
      'id_restaurante': idRestaurante,
      'nome': nome,
      'latitude': latitude,
      'longitude': longitude,
      'tipo_culinaria': tipoCulinaria,
    };
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
