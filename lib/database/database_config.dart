/// Guarda os dados de autenticacao para conexao com o banco MySQL.
class DatabaseConfig {
  final String host;
  final int port;
  final String user;
  final String password;
  final String database;

  const DatabaseConfig({
    required this.host,
    required this.port,
    required this.user,
    required this.password,
    required this.database,
  });

  /// Perfil com permissao total, conforme definido no arquivo database.sql.
  factory DatabaseConfig.admin() {
    return const DatabaseConfig(
      host: 'localhost',
      port: 3306,
      user: 'admin_coma_bem',
      password: '123456',
      database: 'coma_bem',
    );
  }

  /// Perfil somente leitura, conforme definido no arquivo database.sql.
  factory DatabaseConfig.leitura() {
    return const DatabaseConfig(
      host: 'localhost',
      port: 3306,
      user: 'leitura_coma_bem',
      password: '123456',
      database: 'coma_bem',
    );
  }
}
