import '../entities/page_entity.dart';

import './goal_calculator.dart';
import '../enums/goal_status.dart';

class CalculatorResult {

  // Criar função que retona a soma de todas as paginas em metros cúbicos
  static int getTotalCubicMeters(List<PageEntity> pages) {
    if (pages.isEmpty) 
    {
      return 0;
    }
    
    int total = 0;
    for (var page in pages) {
      total += getCubicMeters(page);
    }
    return total;
  }

  static int getCubicMeters(PageEntity page) {
    return page.width * page.thickness * page.amount;
  }
}