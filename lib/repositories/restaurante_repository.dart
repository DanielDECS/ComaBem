import 'package:mysql1/mysql1.dart';

import '../database/database_service.dart';
import '../models/restaurante.dart';

/// Implementa as transacoes de CRUD da tabela restaurante.
class RestauranteRepository {
  final DatabaseService databaseService;

  RestauranteRepository(this.databaseService);

  /// Insere um novo restaurante e retorna o id gerado pelo banco.
  Future<int> inserir(Restaurante restaurante) async {
    final db = await databaseService.connection;
    final result = await db.query(
      '''
      INSERT INTO restaurante (nome, latitude, longitude, tipo_culinaria)
      VALUES (?, ?, ?, ?)
      ''',
      [
        restaurante.nome,
        restaurante.latitude,
        restaurante.longitude,
        restaurante.tipoCulinaria,
      ],
    );

    return result.insertId!;
  }

  /// Consulta todos os restaurantes cadastrados.
  Future<List<Restaurante>> consultarTodos() async {
    final db = await databaseService.connection;
    final results = await db.query(
      'SELECT id_restaurante, nome, latitude, longitude, tipo_culinaria FROM restaurante',
    );

    return results.map(_toRestaurante).toList();
  }

  /// Consulta um restaurante pelo identificador.
  Future<Restaurante?> consultarPorId(int idRestaurante) async {
    final db = await databaseService.connection;
    final results = await db.query(
      '''
      SELECT id_restaurante, nome, latitude, longitude, tipo_culinaria
      FROM restaurante
      WHERE id_restaurante = ?
      ''',
      [idRestaurante],
    );

    if (results.isEmpty) return null;
    return _toRestaurante(results.first);
  }

  /// Altera os dados de um restaurante existente.
  Future<void> alterar(Restaurante restaurante) async {
    if (restaurante.idRestaurante == null) {
      throw ArgumentError('Informe o id_restaurante para alterar o registro.');
    }

    final db = await databaseService.connection;
    await db.query(
      '''
      UPDATE restaurante
      SET nome = ?, latitude = ?, longitude = ?, tipo_culinaria = ?
      WHERE id_restaurante = ?
      ''',
      [
        restaurante.nome,
        restaurante.latitude,
        restaurante.longitude,
        restaurante.tipoCulinaria,
        restaurante.idRestaurante,
      ],
    );
  }

  /// Exclui um restaurante pelo identificador.
  Future<void> excluir(int idRestaurante) async {
    final db = await databaseService.connection;
    await db.query(
      'DELETE FROM restaurante WHERE id_restaurante = ?',
      [idRestaurante],
    );
  }

  Restaurante _toRestaurante(ResultRow row) {
    return Restaurante.fromMap(row.fields);
  }
}
