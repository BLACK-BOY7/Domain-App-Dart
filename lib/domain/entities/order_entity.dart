import 'client_entity.dart';
import 'page_entity.dart';

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
  final int clientId;

  /// Entidade do cliente associado ao pedido.
  ClientEntity? clientEntity;

  

  /// Descrição opcional do pedido.
  String? description;

  /// Inicializa uma nova instância de [OrderEntity] com os dados fornecidos.
  OrderEntity({    
    required this.clientId,
    this.description,
  });

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
      throw ArgumentError.value(id, "id", "O ID deve ser um valor válido maior que zero.");
    }

    _id = id;
  }
}