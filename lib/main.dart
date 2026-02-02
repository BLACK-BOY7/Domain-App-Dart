import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

import 'package:main/domain/entities/page_entity.dart';
import 'package:main/domain/services/calculator_result.dart';

  // 0,0072 bitolado (0,012 x 0,05 x 12) / 1.000.000
  // 0,001524 exportação (0,05 x 0,10 x 0,3048) / 1.000.000

  // 999.900,00 metros lineares

void main() {
  PageEntity pageEntity = PageEntity(
    pageNumber: 1,
    orderId: 1,
    width: 50,
    thickness: 12,
    amount: 12,
  );



  Decimal cubicMeters = CalculatorResult.getCubicMetersStandard(pageEntity);
  
  print("cubicMeters: $cubicMeters");
}
