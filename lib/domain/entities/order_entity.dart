import 'dart:ffi';

import '../enums/order_type.dart';

import 'page_entity.dart';
import 'client_entity.dart';

/// Entidade que representa um pedido no sistema.
/// Cada pedido está associado a um cliente específico.
///
class OrderEntity {
  /// Lista interna de páginas associadas ao pedido.
  final List<PageEntity> _pages = [];

  /// Coleção somente leitura das páginas associadas ao pedido.
  List<PageEntity> get pages => List.unmodifiable(_pages);

  /// Identificador único do pedido.
  int _id = 0;

  /// Identificador do pedido (somente leitura externa).
  int get id => _id;

  /// Identificador do cliente associado ao pedido.
  int clientId;

  /// Entidade do cliente associado ao pedido.
  ClientEntity? _clientEntity;

  /// Entidade do cliente assocado ao pedido (somente leitura externa).
  ClientEntity? get clientEntity => _clientEntity;

  /// Nome da espécie da madeira.
  String _woodSpecie;

  /// Nome da espécie da madeira (somente leitura externa).
  String get woodSpecie => _woodSpecie;

  /// Tipo de pedido.
  final OrderType orderType;

  /// Data de criação do pedido.
  final DateTime _createDate;

  /// Data de criação do pedido (somente leitura externa).
  DateTime get createDate => _createDate;

  /// Data de atualização do pedido.
  DateTime _updateDate;

  /// Data de atualização do pedido (somente leitura externa).
  DateTime get updateDate => _updateDate;

  /// Descrição opcional do pedido.
  String? description;

  /// Inicializa uma nova instância de [OrderEntity] com os dados fornecidos.
  OrderEntity({
    required this.clientId,
    required String woodSpecie,
    required this.orderType,
    required DateTime createDate,
    required DateTime updateDate,
    this.description = "Sem descrição",
  }) : _woodSpecie = woodSpecie,
       _createDate = createDate,
       _updateDate = updateDate;

  /// Define o identificador do pedido.
  ///
  /// Regras:
  /// - O [id] deve ser maior que zero
  /// - O [id] só pode ser definido uma única vez
  ///
  /// Lança um [ArgumentError] se o valor for inválido.
  ///
  /// Lança um [StateError] se o identificador já estiver definido.
  void setId(int id) {
    if (_id != 0) {
      throw StateError('Id já definido');
    }

    if (id <= 0) {
      throw ArgumentError.value(
        id,
        "id",
        "O ID deve ser um valor válido maior que zero.",
      );
    }
    _id = id;
  }

  /// Remove todas as entidades [PageEntity] da lista de páginas(pages).
  void clearAllPageEntity() {
    _pages.clear();
  }

  /// Remove a entidade [PageEntity] da lista de páginas(pages) usando a entidade [PageEntity].
  void removePageEntity(PageEntity pageEntity) {
    _pages.remove(pageEntity);
  }

  /// Remove a entidade do cliente associada ao pedido.
  void removeClientEntity() {
    _clientEntity = null;
  }

  /// Substitui completamente a lista de páginas do pedido.
  ///
  /// A coleção atual de páginas é limpa antes da adição das novas páginas[PageEntity].
  ///
  /// Exceções:
  /// - Lança um [StateError] se algum item da coleção ter o [PageEntity.orderId] diferente de [OrderEntity.id].
  void addPages(List<PageEntity> pages) {
    _pages.clear();
    pages.forEach(addPage);
  }

  /// Adiciona uma nova página ao pedido.
  ///
  /// O [PageEntity.orderId] deve corresponder ao [OrderEntity.id] do pedido.
  ///
  /// Exceções:
  /// - Lança um [StateError] se [PageEntity.pageId] for diferente de [OrderEntity.id].
  void addPage(PageEntity pageEntity) {
    if (pageEntity.orderId != id) {
      throw StateError(
        'PageEntity.orderId=${pageEntity.orderId} não corresponde ao OrderEntity.id=$id',
      );
    }
    _pages.add(pageEntity);
  }

  /// Adiciona a entidade do cliente ao pedido.
  ///
  /// Parâmetros:
  /// - [clientEntity]: A entidade do cliente.
  ///
  /// Exceções:
  /// - Lança um [StateError] se [ClientEntity.id] for diferente do [OrderEntity.clientId].
  void addClientEntity(ClientEntity clientEntity) {
    if (clientEntity.id != clientId) {
      throw StateError(
        "ClientEntity.id=${clientEntity.id} não corresponde ao OrderEntity.clientId=$clientId",
      );
    }

    _clientEntity = clientEntity;
  }

  /// Altera a entidade do cliente associado ao pedido.
  /// Altera o indentificador do cliente associado ao pedido.
  ///
  /// Parâmetros:
  /// - [newClientEntity] A nova entidade do cliente a ser associada ao pedido.
  ///
  /// Regras:
  /// - O [ClientEntity.id] não pode ser menor ou igual a zero.
  ///
  /// Exceções:
  /// - Lança um [StateError] se as regras não forem atendidas.
  void changeClientEntity(ClientEntity newClientEntity) {
    if (newClientEntity.id <= 0) {
      throw StateError(
        "newClientEntity.id=${newClientEntity.id} não pode ser menor ou igual a zero.",
      );
    }

    clientId = newClientEntity.id;
    _clientEntity = newClientEntity;
  }

  /// Altera o nome da espécie da madeira do pedido.
  ///
  /// Parâmetros:
  /// - [newWoodSpecie]: Novo nome da espécie.
  ///
  /// Regras:
  /// - O [newWoodSpecie] não pode está vazio.
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeWoodSpecie(String newWoodSpecie) {
    _woodSpecie = _validateWoodSpecie(newWoodSpecie);
  }

  /// Altera a data de atualização do pedido.
  ///
  /// Parâmetros:
  /// - [newUpdateDate]: Nova data de modificação.
  void changeUpdateDate(DateTime newUpdateDate) {
    _updateDate = newUpdateDate;
  }

  /// Altera a descrição do pedido.
  ///
  /// Parâmetros:
  /// - [newDescription]: Nova descrição.
  void changeDescription(String newDescription) {
    description = newDescription;
  }

  /// Valida o nome da espécie fornecida.
  ///
  /// Parâmetros:
  /// - [woodSpecie]: Nome da espécie a ser validado.
  ///
  /// Regras:
  /// - O [woodSpecie] não pode está vazio.
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  String _validateWoodSpecie(String woodSpecie) {
    if (woodSpecie.trim().isEmpty) {
      throw ArgumentError.value(
        woodSpecie,
        "woodSpecie",
        "O Nome da espécie da madeira não pode está vazio",
      );
    }
    return woodSpecie;
  }
}
