import '../entities/client_entity.dart';

abstract class ClientRepository {
  /// Obtém um cliente do banco de dados usando seu id.
  ///
  /// Parâmetros:
  /// - [id] O id do cliente.
  Future<ClientEntity> getByIdAsync(int id);

  /// Obtém um cliente do banco de dados usando seu nome.
  /// 
  /// Parâmetros:
  /// - [name] O nome do cliente.
  /// 
  /// Regras:
  /// - O [name] Não pode ser vazio.
  /// 
  /// Exceções:
  /// - Lança [ArgumentError] caso [name] esteja vazio.
  Future<ClientEntity?> getByNameAsync(String name);

  /// Deleta um cliente do banco de dados usando sua entidade.
  ///
  /// Parâmetros:
  /// - [clientEntity] A entidade do cliente.
  Future<void> deleteAsync(ClientEntity clientEntity);

  /// Delata um cliente do banco de dados usando o id.
  ///
  /// Parâmetros:
  /// - [id] O id do cliente.
  Future<void> deleteByIdAsync(int id);

  /// Inserir um cliente ao banco de dados usando sua entidade.
  ///
  /// Parâmetros:
  /// - [clientEntity] A entidade do cliente.
  Future<void> insertAsync(ClientEntity clientEntity);

  /// Atualizar um cliente do banco de dados usando sua entidade.
  ///
  /// Parâmetros:
  /// - [clientEntity] A entidade do cliente.
  Future<void> updateAsync(ClientEntity clientEntity);
}
