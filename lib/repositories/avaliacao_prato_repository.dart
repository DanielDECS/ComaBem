import 'package:mysql1/mysql1.dart';

import '../database/database_service.dart';
import '../models/avaliacao_prato.dart';

/// Implementa as transacoes de CRUD da tabela avaliacao_prato.
class AvaliacaoPratoRepository {
  final DatabaseService databaseService;

  AvaliacaoPratoRepository(this.databaseService);

  /// Insere uma nova avaliacao de prato e retorna o id gerado pelo banco.
  Future<int> inserir(AvaliacaoPrato avaliacao) async {
    final db = await databaseService.connection;
    final result = await db.query(
      '''
      INSERT INTO avaliacao_prato (id_prato, ranking, recomendacao)
      VALUES (?, ?, ?)
      ''',
      [avaliacao.idPrato, avaliacao.ranking, avaliacao.recomendacao],
    );

    return result.insertId!;
  }

  /// Consulta todas as avaliacoes cadastradas.
  Future<List<AvaliacaoPrato>> consultarTodas() async {
    final db = await databaseService.connection;
    final results = await db.query(
      'SELECT id_avaliacao, id_prato, ranking, recomendacao FROM avaliacao_prato',
    );

    return results.map(_toAvaliacao).toList();
  }

  /// Consulta as avaliacoes vinculadas a um prato.
  Future<List<AvaliacaoPrato>> consultarPorPrato(int idPrato) async {
    final db = await databaseService.connection;
    final results = await db.query(
      '''
      SELECT id_avaliacao, id_prato, ranking, recomendacao
      FROM avaliacao_prato
      WHERE id_prato = ?
      ''',
      [idPrato],
    );

    return results.map(_toAvaliacao).toList();
  }

  /// Altera ranking e recomendacao de uma avaliacao existente.
  Future<void> alterar(AvaliacaoPrato avaliacao) async {
    if (avaliacao.idAvaliacao == null) {
      throw ArgumentError('Informe o id_avaliacao para alterar o registro.');
    }

    final db = await databaseService.connection;
    await db.query(
      '''
      UPDATE avaliacao_prato
      SET id_prato = ?, ranking = ?, recomendacao = ?
      WHERE id_avaliacao = ?
      ''',
      [
        avaliacao.idPrato,
        avaliacao.ranking,
        avaliacao.recomendacao,
        avaliacao.idAvaliacao,
      ],
    );
  }

  /// Exclui uma avaliacao pelo identificador.
  Future<void> excluir(int idAvaliacao) async {
    final db = await databaseService.connection;
    await db.query(
      'DELETE FROM avaliacao_prato WHERE id_avaliacao = ?',
      [idAvaliacao],
    );
  }

  AvaliacaoPrato _toAvaliacao(ResultRow row) {
    return AvaliacaoPrato.fromMap(row.fields);
  }
}
