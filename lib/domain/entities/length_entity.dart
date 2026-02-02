import '../enums/order_type.dart';

/// Entidade que representa um comprimento associado a uma página.
class LengthEntity {
  /// Quantidade máxima permitido para a entidade de comprimento.
  /// Padrão: 999 unidades.
  static const int maxAmount = 999; // 999 unidades por comprimento

  /// Tamanho máximo permitido para o comprimento em milímetros.
  /// Padrão: 100.000 mm (100 metros).
  static const int maxLengthSize = 100_000; // 100 metros em milímetros

  /// Identificador único da entidade de comprimento.
  int _id = 0;

  /// Identificador da entidade de comprimento (somente leitura externa).
  int get id => _id;

  /// Identificador da página associada à entidade de comprimento.
  final int pageId;

  /// Tamanho do comprimento em milímetros.
  int _lengthSize;

  /// Tamanho do comprimento (somente leitura externa).
  ///
  /// Representa a medida do comprimento em milímetros.
  ///
  /// Exemplo:
  /// - 2500mm equivale a 2,5 metros.
  int get lengthSize => _lengthSize;

  /// Quantidade atual de unidades relacionadas ao comprimento.
  int _currentAmount;

  /// Quantidade atual de unidades relacionadas ao comprimento (somente leitura externa).
  ///
  /// Pode ser usada para rastrear o progresso ou status atual.    
  int get currentAmount => _currentAmount;

  /// Quantidade desejada de unidades relacionadas ao comprimento.
  int _desiredAmount;

  /// Quantidade desejada de unidades relacionadas ao comprimento (somente leitura externa).
  ///
  /// Pode ser usada para definir uma meta ou objetivo.    
  int get desiredAmount => _desiredAmount;

  /// Índice do registro do comprimento.
  ///
  /// Diferente do [id], este índice pode ser usado para ordenar ou identificar o comprimento em um contexto específico.
  ///
  /// Exemplo: pode ser usado para identificar outro [LengthEntity] com o mesmo tamanho em uma [PageEntity] diferente.
  ///
  /// Observação:
  /// - O exemplo acima so e válido ser ao registrar os comprimentos em uma pagina de pedido de forma pradonizada.
  /// Neste caso, o [registryIndex] ajuda a distinguir entre comprimentos idênticos.
  final int registryIndex;

  /// Indica se o comprimento é o padrão do sistema, ou seja, se foi criado automaticamente pelo sistema.
  ///
  /// Uso típico: [true] para comprimentos padrão do sistema, [false] para comprimentos personalizados, criados pelo usuário.
  ///
  /// Observação:
  /// - Esta propriedade é desenvolvida para ser auxiliar na identificação de comprimentos padrão do sistema. possibilitando ações específicas, como evitar exclusão ou modificação.
  bool isSystemDefault = true;

  /// Inicializa uma nova instância de [LengthEntity] com os valores fornecidos.
  ///
  /// Parâmetros obrigatórios:
  /// - [pageId]: Identificador da página associada.
  /// - [lengthSize]: Tamanho do comprimento em metros, limitado por [maxLengthSize].
  /// - [registryIndex]: Índice do registro do comprimento.
  ///
  /// Parâmetros opcionais:
  /// - [currentAmount]: Quantidade atual (padrão é 0) limitada por [maxAmount].
  /// - [desiredAmount]: Quantidade desejada (padrão é 0) limitada por [maxAmount].
  /// - [isSystemDefault]: Indica se é padrão do sistema (padrão é true).
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  LengthEntity({
    required this.pageId,
    required int lengthSize,
    required this.registryIndex,
    int currentAmount = 0,
    int desiredAmount = 0,
    int width = 0,
    this.isSystemDefault = true,
  }) : _lengthSize = _validateLengthSize(lengthSize),
       _currentAmount = _validateAmount(currentAmount),
       _desiredAmount = _validateAmount(desiredAmount);

  /// Define o identificador único da entidade de comprimento.
  ///
  /// Regras:
  /// - O [id] deve ser maior que zero.
  /// - O [id] só pode ser definido uma única vez.
  ///
  /// Exceções:
  /// - Lança uma [StateError] se o ID já foi definido.
  /// - Lança uma [ArgumentError] se o [id] não for válido.
  void setId(int id) {
    if (_id != 0) {
      throw StateError("O ID já foi definido e não pode ser alterado.");
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

  /// Altera o tamanho do comprimento em milímetros.
  ///
  /// Parâmetros:
  /// - [newLengthSize]: Novo tamanho do comprimento a ser definido.
  ///
  /// Regras:
  /// - O [newLengthSize] deve ser maior que zero.
  /// - O [newLengthSize] não pode exceder o limite máximo definido por [maxLengthSize].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeLengthSize(int newLengthSize) {
    _lengthSize = _validateLengthSize(newLengthSize);
  }

  /// Altera a quantidade atual de unidades relacionadas ao comprimento.
  ///
  /// Parâmetros:
  /// - [newCurrentAmount]: Nova quantidade atual a ser definida.
  ///
  /// Regras:
  /// - O [newCurrentAmount] não pode ser negativo.
  /// - O [newCurrentAmount] não pode exceder o limite máximo definido por [maxAmount].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeCurrentAmount(int newCurrentAmount) {
    _currentAmount = _validateAmount(newCurrentAmount);
  }

  /// Altera a quantidade desejada de unidades relacionadas ao comprimento.
  ///
  /// Parâmetros:
  /// - [newDesiredAmount]: Nova quantidade desejada a ser definida.
  ///
  /// Regras:
  /// - O [newDesiredAmount] não pode ser negativo.
  /// - O [newDesiredAmount] não pode exceder o limite máximo definido por [maxAmount].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  void changeDesiredAmount(int newDesiredAmount) {
    _desiredAmount = _validateAmount(newDesiredAmount);
  }

  /// Valida o tamanho do comprimento fornecido.
  ///
  /// Parâmetros:
  /// - [lengthSize]: Tamanho do comprimento a ser validado.
  ///
  /// Regras:
  /// - O [lengthSize] deve ser maior que zero.
  /// - O [lengthSize] não pode exceder o limite máximo definido por [maxLengthSize].
  ///
  /// Exceções:
  /// - Lança uma [ArgumentError] se as regras não forem atendidas.
  static int _validateLengthSize(int lengthSize) {
    if (lengthSize <= 0 || lengthSize > maxLengthSize) {
      throw ArgumentError.value(
        lengthSize,
        "lengthSize",
        "O tamanho do comprimento deve ser maior que zero e não pode exceder $maxLengthSize mm.",
      );
    }
    return lengthSize;
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
}
