import 'package:mysql1/mysql1.dart';

import 'database_config.dart';

/// Classe responsavel por abrir e encerrar conexoes autenticadas com o MySQL.
class DatabaseService {
  final DatabaseConfig config;
  MySqlConnection? _connection;

  DatabaseService(this.config);

  /// Abre uma conexao usando os dados de autenticacao do perfil informado.
  Future<MySqlConnection> connect() async {
    _connection ??= await MySqlConnection.connect(
      ConnectionSettings(
        host: config.host,
        port: config.port,
        user: config.user,
        password: config.password,
        db: config.database,
      ),
    );

    return _connection!;
  }

  /// Retorna uma conexao ativa para executar consultas e transacoes.
  Future<MySqlConnection> get connection async {
    return _connection ?? await connect();
  }

  /// Fecha a conexao aberta com o banco de dados.
  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
