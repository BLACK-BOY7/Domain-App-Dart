import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';

import 'package:main/domain/enums/order_type.dart';
import 'package:main/services/generate_entity.dart';
import 'package:main/domain/entities/order_entity.dart';
import 'package:main/domain/services/calculator_result.dart';


void main() {
  GenerateEntity generateEntity = GenerateEntity(
    clientName: "Edilson Filho",
    woodSpecie: "Maçaranduba",
    orderType: OrderType.standard,
  );

  OrderEntity orderEntity = generateEntity.createCompleteEntity();

  Decimal linearMeters = CalculatorResult.getTotalLinearMetersOfPage(
    orderEntity.pages[0],
  );
  Decimal cubicMeters = CalculatorResult.getCubicMetersStandard(
    orderEntity.pages[0],
  );

  NumberFormat numberFormat = NumberFormat("#,##0.000", "pt_BR");

  print("Metros lineares: ${numberFormat.format(linearMeters.toDouble())}m");
  print("Metros cubicos: ${numberFormat.format(cubicMeters.toDouble())}m³");
}

// Agora e so desenvolver os services de exporta a entidade
// .pdf e .xlsx