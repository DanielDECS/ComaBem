import 'package:mysql1/mysql1.dart';

import '../database/database_service.dart';
import '../models/prato.dart';

/// Implementa as transacoes de CRUD da tabela prato.
class PratoRepository {
  final DatabaseService databaseService;

  PratoRepository(this.databaseService);

  /// Insere um novo prato e retorna o id gerado pelo banco.
  Future<int> inserir(Prato prato) async {
    final db = await databaseService.connection;
    final result = await db.query(
      '''
      INSERT INTO prato (nome_prato, foto_prato, id_restaurante)
      VALUES (?, ?, ?)
      ''',
      [prato.nomePrato, prato.fotoPrato, prato.idRestaurante],
    );

    return result.insertId!;
  }

  /// Consulta todos os pratos cadastrados.
  Future<List<Prato>> consultarTodos() async {
    final db = await databaseService.connection;
    final results = await db.query(
      'SELECT id_prato, nome_prato, foto_prato, id_restaurante FROM prato',
    );

    return results.map(_toPrato).toList();
  }

  /// Consulta os pratos vinculados a um restaurante.
  Future<List<Prato>> consultarPorRestaurante(int idRestaurante) async {
    final db = await databaseService.connection;
    final results = await db.query(
      '''
      SELECT id_prato, nome_prato, foto_prato, id_restaurante
      FROM prato
      WHERE id_restaurante = ?
      ''',
      [idRestaurante],
    );

    return results.map(_toPrato).toList();
  }

  /// Altera os dados de um prato existente.
  Future<void> alterar(Prato prato) async {
    if (prato.idPrato == null) {
      throw ArgumentError('Informe o id_prato para alterar o registro.');
    }

    final db = await databaseService.connection;
    await db.query(
      '''
      UPDATE prato
      SET nome_prato = ?, foto_prato = ?, id_restaurante = ?
      WHERE id_prato = ?
      ''',
      [prato.nomePrato, prato.fotoPrato, prato.idRestaurante, prato.idPrato],
    );
  }

  /// Exclui um prato pelo identificador.
  Future<void> excluir(int idPrato) async {
    final db = await databaseService.connection;
    await db.query('DELETE FROM prato WHERE id_prato = ?', [idPrato]);
  }

  Prato _toPrato(ResultRow row) {
    return Prato.fromMap(row.fields);
  }
}
