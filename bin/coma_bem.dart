import 'package:coma_bem/database/database_config.dart';
import 'package:coma_bem/database/database_service.dart';
import 'package:coma_bem/models/avaliacao_prato.dart';
import 'package:coma_bem/models/prato.dart';
import 'package:coma_bem/models/restaurante.dart';
import 'package:coma_bem/repositories/avaliacao_prato_repository.dart';
import 'package:coma_bem/repositories/prato_repository.dart';
import 'package:coma_bem/repositories/restaurante_repository.dart';

/// Exemplo simples de uso das classes de conexao e transacao.
Future<void> main() async {
  final database = DatabaseService(DatabaseConfig.admin());
  final restaurantes = RestauranteRepository(database);
  final pratos = PratoRepository(database);
  final avaliacoes = AvaliacaoPratoRepository(database);

  try {
    final idRestaurante = await restaurantes.inserir(
      Restaurante(
        nome: 'Coma Bem Centro',
        latitude: -25.4284,
        longitude: -49.2733,
        tipoCulinaria: 'Italiana',
      ),
    );

    final idPrato = await pratos.inserir(
      Prato(
        nomePrato: 'Lasanha',
        fotoPrato: 'lasanha.jpg',
        idRestaurante: idRestaurante,
      ),
    );

    await avaliacoes.inserir(
      AvaliacaoPrato(
        idPrato: idPrato,
        ranking: 5,
        recomendacao: 'Excelente prato!',
      ),
    );

    final lista = await restaurantes.consultarTodos();
    for (final restaurante in lista) {
      print('${restaurante.idRestaurante} - ${restaurante.nome}');
    }
  } finally {
    await database.close();
  }
}
