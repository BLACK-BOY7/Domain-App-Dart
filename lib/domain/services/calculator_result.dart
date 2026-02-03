import 'package:decimal/decimal.dart';

import '../enums/order_type.dart';
import '../entities/page_entity.dart';
import '../entities/order_entity.dart';

class CalculatorResult {
  /// Usado para calculor da bitola de exportação.
  static final Decimal _factor3048 = Decimal.parse("0.3048");

  /// Usado para divisão do calculor da bitola.
  static final Decimal _divisorSectionArea = Decimal.fromInt(1_000_000);

  /// Retora o totla de metros cubicos indepedente do tipo do pedido.
  static Decimal getTotalCubicMeters(OrderEntity orderEntity) {
    if (orderEntity.orderType == OrderType.standard) {
      return getTotalCubicMetersStandard(orderEntity.pages);
    }
    return getTotalCubicMetersExport(orderEntity.pages);
  }

  /// Retorna o total de metros cubicos para uma lista de páginas do tipo: [OrderType.standard].
  ///
  /// Parâmetros:
  /// - [pages]: Lista de páginas para calcular o total de metros cúbicos.
  static Decimal getTotalCubicMetersStandard(List<PageEntity> pages) {
    Decimal total = Decimal.zero;

    for (var page in pages) {
      total += getCubicMetersStandard(page);
    }

    return total;
  }

  /// Retorna o total de metros cubicos para uma lista de páginas do tipo: [OrderType.export].
  ///
  /// Parâmetros:
  /// - [pages]: Lista de páginas para calcular o total de metros cúbicos.
  static Decimal getTotalCubicMetersExport(List<PageEntity> pages) {
    Decimal total = Decimal.zero;

    for (var page in pages) {
      total += getCubicMetersExport(page);
    }

    return total;
  }

  /// Retorna metros cubicos para pedido do tipo: [OrderType.standard].
  /// Usa a bitola padrão.
  static Decimal getCubicMetersStandard(PageEntity pageEntity) {
    return getSectionAreaStandard(pageEntity) *
        getTotalLinearMetersOfPage(pageEntity);
  }

  /// Retorna metros cubicos para pedido do tipo: [OrderType.export].
  /// Usa a bitola de exportação.
  static Decimal getCubicMetersExport(PageEntity pageEntity) {
    return getSectionAreaExport(pageEntity) *
        getTotalLinearMetersOfPage(pageEntity);
  }

  /// Retorna o total de metros lineares de uma lista de páginas.
  ///
  /// Parâmetros:
  /// - [pages]: Lista de páginas para calcular o total de metros lineares.
  static Decimal getTotalLinearMetersOfPages(List<PageEntity> pages) {
    Decimal total = Decimal.zero;

    for (var page in pages) {
      total += getTotalLinearMetersOfPage(page);
    }

    return total;
  }

  /// Retorna o total de metros lineares de uma página.
  static Decimal getTotalLinearMetersOfPage(PageEntity pageEntity) {
    int totalLinearMeters = 0;
    for (var length in pageEntity.lengths) {
      totalLinearMeters += pageEntity.amount > 0
          ? (length.lengthSize * length.currentAmount * pageEntity.amount)
          : (length.lengthSize * length.currentAmount);
    }
    return (Decimal.fromInt(totalLinearMeters) / Decimal.fromInt(1_000))
        .toDecimal();
  }

  /// Retona o calculor da bitola do pedido do tipo: [OrderType.standard].
  static Decimal getSectionAreaStandard(PageEntity pageEntity) {
    final Decimal width = Decimal.fromInt(pageEntity.width);
    final Decimal thickness = Decimal.fromInt(pageEntity.thickness);

    return ((width * thickness) / _divisorSectionArea).toDecimal();
  }

  /// Retona o calculor da bitola do pedido do tipo: [OrderType.export].
  static Decimal getSectionAreaExport(PageEntity pageEntity) {
    final Decimal width = Decimal.fromInt(pageEntity.width);
    final Decimal thickness = Decimal.fromInt(pageEntity.thickness);

    return ((width * thickness * _factor3048) / _divisorSectionArea)
        .toDecimal();
  }
}
