import 'order_entity.dart';

/// Representa um cliente do domínio.
///
/// Um cliente pode possuir múltiplos pedidos associados.
class ClientEntity {
  /// Lista interna de pedidos associados ao cliente.
  final List<OrderEntity> _orders = [];

  /// Coleção somente leitura dos pedidos associados ao cliente.
  List<OrderEntity> get orders => List.unmodifiable(_orders);

  /// Identificador único do cliente.
  ///
  /// É definido internamente e só pode ser atribuído uma única vez.
  int _id = 0;

  /// Identificador do cliente (somente leitura externa).
  int get id => _id;

  /// Nome do cliente.
  final String name;

  /// Inicializa uma nova instância de [ClientEntity] com o nome informado.
  ClientEntity(this.name);

  /// Define o identificador do cliente caso ele ainda não tenha sido definido.
  ///
  /// Regras:
  /// - O [id] deve ser maior que zero.
  /// - O [id] só pode ser definido uma única vez.
  ///
  /// Exceções:
  /// - Lança um [ArgumentError] se o valor for inválido.
  /// - Lança um [StateError] se o identificador já estiver definido.
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

  /// Remove todas as entidades [OrderEntity] da lista de pedidos(orders).
  void clearAllOrderEntity() {
    _orders.clear();
  }

  /// Remove a entidade [OrderEntity] da lista de pedidos(orders) usando a entidade [OrderEntity].
  void removeOrderEntity(OrderEntity orderEntity) {
    _orders.remove(orderEntity);
  }

  /// Substitui completamente a lista de pedidos do cliente.
  ///
  /// A coleção atual de pedidos é limpa antes da adição dos novos pedidos[OrderEntity].
  ///
  /// Exceções:
  /// - Lança um [StateError] se algum item da coleção ter o [OrderEntity.clientId] diferente de [ClientEntity.id].
  void addOrders(List<OrderEntity> orders) {
    _orders.clear();
    orders.forEach(addOrder);
  }

  /// Adiciona um pedido ao cliente.
  ///
  /// O [OrderEntity.clientId] deve corresponder ao [id] do cliente.
  void addOrder(OrderEntity orderEntity) {
    if (orderEntity.clientId != id) {
      throw StateError(
        'OrderEntity.clientId=${orderEntity.clientId} não corresponde ao Client.id=$id',
      );
    }
    _orders.add(orderEntity);
  }
}
