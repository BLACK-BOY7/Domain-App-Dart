import 'length_entity.dart';
import '../enums/order_type.dart';


/// Representa uma página do domínio.
///
/// Uma página está associada a uma entidade de pedido e contém múltiplas entidades de comprimento.
class PageEntity {
  /// Largura máxima permitida para a bitola em milímetros.
  ///
  /// Padrão: 1.000 mm (1 metro).
  static const int maxWidth = 1_000; // 1 metro em milímetros

  /// Espessura máxima permitida para a bitola em milímetros.
  ///
  /// Padrão: 1.000 mm (1 metro).
  static const int maxThickness = 1_000; // 1 metro em milímetros

  /// Quantidade máxima permitida de peças por pacote.
  ///
  /// Padrão: 100 peças.
  static const int maxAmount = 100; // 100 peças por pacote

  /// Volume máximo desejado permitido para o pedido em decímetros cubicos.
  ///
  /// Padrão: 100.000 dm³ (100 metros cubicos).
  static const int maxDesiredCubicMeters =
      100_000; // 100 metros cubicos em decímetros cubicos

  /// Identificador único da entidade de página.
  int _id = 0;

  /// Identificador único da entidade de página (somente leitura externa).
  int get id => _id;

  /// Identificador da entidade do pedido associada à página.
  final int orderId;

  /// Coleção interna de comprimentos associados à página.
  final List<LengthEntity> _lengths = [];

  /// Coleção somente leitura das entidades de comprimento associadas à página.
  List<LengthEntity> get lengths => List.unmodifiable(_lengths);

  /// Número da página.
  final int pageNumber;

  /// Largura da bitola em milímetros.
  int _width;

  /// Largura da bitola em milímetros (somente leitura externa).
  ///
  /// Exemplo: 50mm equivalem a 5 cm.    
  int get width => _width;

  /// Espessura da bitola em milímetros.
  ///
  int _thickness;

  /// Espessura da bitola em milímetros (somente leitura externa).
  /// 
  /// Exemplo: 100mm equivalem a 10 cm.  
  int get thickness => _thickness;

  /// Quantidade de peças por pacote.
  int _amount;

  /// Quantidade de peças por pacote (somente leitura externa).
  ///
  /// Exemplo: 12 peças.
  int get amount => _amount;

  /// Quantidade desejada de metros cúbicos.
  int _desiredCubicMeters;

  /// Quantidade desejada de metros cúbicos (somente leitura externa).
  int get desiredCubicMeters => _desiredCubicMeters;

  /// Inicializa uma nova instância de [PageEntity] com os valores fornecidos.
  ///
  /// Parâmetros obrigatórios:
  /// - [pageNumber]: Numero da página.
  /// - [orderId]: Identificador do pedido associada.
  ///
  /// Parâmetros opcionais:
  /// - [width]: Largura da bitola em milímetros (padrão é 0), limitada por [maxWidth].
  /// - [thickness]: Espessura da bitola em milímetros (padrão é 0), limitada por [maxThickness].
  /// - [amount]: Quantidade de peças por pacote em unidades (padrão é 0), limitado por [maxAmount].
  /// - [desiredCubicMeters]: Volumes cubicos em decímetros cubicos (padrão é 0), limtado por [maxDesiredCubicMeters].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  PageEntity({
    required this.pageNumber,
    required this.orderId,
    int width = 0,
    int thickness = 0,
    int amount = 0,
    int desiredCubicMeters = 0,
  }) : _width = _validateWidth(width),
       _thickness = _validateThickness(thickness),
       _amount = _validateAmount(amount),
       _desiredCubicMeters = _validateDesiredCubicMeters(desiredCubicMeters);

  /// Define o identificador da página.
  ///
  /// Regras:
  /// - O [id] deve ser maior que zero
  /// - O [id] só pode ser definido uma única vez
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

  /// Remove todas as entidades [LengthEntity] da lista de comprimentos(lengths).
  void clearAllLengthEntity() {
    _lengths.clear();
  }

  /// Remove a entidade [LengthEntity] da lista de comprimentos(lengths) usando o [registryIndex].
  void removeLengthRegistryIndex(int registryIndex) {
    _lengths.removeWhere((length) => length.registryIndex == registryIndex);
  }

  /// Remove a entidade [LengthEntity] da lista de comprimentos(lengths) usando a entidade [LengthEntity].
  void removeLengthEntity(LengthEntity lengthEntity) {
    _lengths.remove(lengthEntity);
  }

  /// Substitui completamente a lista de comprimentos da página.
  ///
  /// A coleção atual de comprimentos é limpa antes da adição dos novos comprimentos[LengthEntity].
  ///
  /// Exceções:
  /// - Lança um [StateError] se algum item da coleção ter o [LengthEntity.pageId] diferente de [PageEntity.id].
  void addLengths(List<LengthEntity> lengths) {
    _lengths.clear();
    lengths.forEach(addLength);
  }

  /// Adiciona um comprimento a página.
  ///
  /// O [LengthEntity.pageId] deve corresponder ao [id] da página.
  ///
  /// Exceções:
  /// - Lança um [StateError] se [LengthEntity.pageId] for diferente de [PageEntity.id].
  void addLength(LengthEntity lengthEntity) {
    if (lengthEntity.pageId != id) {
      throw StateError(
        'LengthEntity.pageId=${lengthEntity.pageId} não corresponde ao PageEntity.id=$id',
      );
    }
    _lengths.add(lengthEntity);
  }

  /// Altera a largura da bitola em milímetros.
  ///
  /// Parâmetros:
  /// - [newWidth]: Nova largura a ser definida.
  ///
  /// Regras:
  /// - O [newWidth] não pode ser negativo.
  /// - O [newWidth] não pode exceder o limite máximo definido por [maxWidth].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeWidth(int newWidth) {
    _width = _validateWidth(newWidth);
  }

  /// Altera a espessura da bitola em milímetros.
  ///
  /// Parâmetros:
  /// - [newThickness]: Nova espessura a ser definida.
  ///
  /// Regras:
  /// - O [newThickness] não pode ser negativo.
  /// - O [newThickness] não pode exceder o limite máximo definido por [maxThickness].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeThickness(int newThickness) {
    _thickness = _validateThickness(newThickness);
  }

  /// Altera a quantidade de peças por pacote em unidades.
  ///
  /// Parâmetros:
  /// - [newAmount]: Nova quantidade a ser definida.
  ///
  /// Regras:
  /// - O [newAmount] não pode ser negativo.
  /// - O [newAmount] não pode exceder o limite máximo definido por [maxAmount].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeAmount(int newAmount) {
    _amount = _validateAmount(newAmount);
  }

  /// Altera o volume cubico desejado em decímetro cubico.
  ///
  /// Parâmetros:
  /// - [newDesiredCubicMeters]: Novo volume cubico desejado a ser definida.
  ///
  /// Regras:
  /// - O [newDesiredCubicMeters] não pode ser negativo.
  /// - O [newDesiredCubicMeters] não pode exceder o limite máximo definido por [maxDesiredCubicMeters].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeDesiredCubicMeters(int newDesiredCubicMeters) {
    _desiredCubicMeters = _validateDesiredCubicMeters(newDesiredCubicMeters);
  }

  /// Valida a largura fornecida.
  ///
  /// Parâmetros:
  /// - [width]: Largura a ser validada.
  ///
  /// Regras:
  /// - O [width] não pode ser negativo.
  /// - O [width] não pode exceder o limite máximo definido por [maxWidth].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  static int _validateWidth(int width) {
    if (width < 0 || width > maxWidth) {
      throw ArgumentError.value(
        width,
        "width",
        "A largura deve ser maior ou igual a zero e não pode exceder $maxWidth mm.",
      );
    }
    return width;
  }

  /// Valida a espessura fornecida.
  ///
  /// Parâmetros:
  /// - [thickness]: Espessura a ser validada.
  ///
  /// Regras:
  /// - O [thickness] não pode ser negativo.
  /// - O [thickness] não pode exceder o limite máximo definido por [thickness].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  static int _validateThickness(int thickness) {
    if (thickness < 0 || thickness > maxThickness) {
      throw ArgumentError.value(
        thickness,
        "thickness",
        "A espessura deve ser maior ou igual a zero e não pode exceder $maxThickness mm.",
      );
    }
    return thickness;
  }

  /// Valida a quantidade fornecida.
  ///
  /// Parâmetros:
  /// - [amount]: Quantidade a ser validada.
  ///
  /// Regras:
  /// - O [amount] não pode ser negativo.
  /// - O [amount] não pode exceder o limite máximo definido por [maxAmount].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  static int _validateAmount(int amount) {
    if (amount < 0 || amount > maxAmount) {
      throw ArgumentError.value(
        amount,
        "amount",
        "A quantidade deve ser maior ou igual a zero e não pode exceder $maxAmount unidades.",
      );
    }
    return amount;
  }

  /// Valida o volume cubico desejado fornecido.
  ///
  /// Parâmetros:
  /// - [desiredCubicMeters]: Volume cubico a ser validado.
  ///
  /// Regras:
  /// - O [desiredCubicMeters] não pode ser negativo.
  /// - O [desiredCubicMeters] não pode exceder o limite máximo definido por [maxDesiredCubicMeters]
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  static int _validateDesiredCubicMeters(int desiredCubicMeters) {
    if (desiredCubicMeters < 0 || desiredCubicMeters > maxDesiredCubicMeters) {
      throw ArgumentError.value(
        desiredCubicMeters,
        "desiredCubicMeters",
        "O volume cubico deve ser maior ou igual a zero e não pode exceder $maxDesiredCubicMeters volumes cubicos.",
      );
    }
    return desiredCubicMeters;
  }
}
