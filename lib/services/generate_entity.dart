import 'package:main/domain/entities/length_entity.dart';
import 'package:main/domain/entities/page_entity.dart';
import 'package:main/domain/enums/order_type.dart';
import 'package:main/domain/entities/order_entity.dart';
import 'package:main/domain/entities/client_entity.dart';

class GenerateEntity {
  final String clientName;
  final String woodSpecie;
  final OrderType orderType;

  int _pageId = 1;
  int _lengthId = 1;

  GenerateEntity({
    required this.clientName,
    required this.woodSpecie,
    required this.orderType,
  });

  OrderEntity createCompleteEntity() {
    if (orderType == OrderType.standard) {
      return _createStandardOrderEntity();
    }
    return _createExportOrderEntity();
  }

  OrderEntity _createStandardOrderEntity() {
    ClientEntity clientEntity = ClientEntity(clientName);
    clientEntity.setId(1);

    OrderEntity orderEntity = _createOrderEntity(clientEntity.id);
    orderEntity.addClientEntity(clientEntity);
    orderEntity.addPages(
      _createCompletePageEntitesStandardOrder(orderEntity.id),
    );

    return orderEntity;
  }

  OrderEntity _createExportOrderEntity() {
    ClientEntity clientEntity = ClientEntity(clientName);
    clientEntity.setId(1);

    OrderEntity orderEntity = _createOrderEntity(clientEntity.id);
    orderEntity.addClientEntity(clientEntity);
    orderEntity.addPages();

    return orderEntity;
  }

  List<PageEntity> _createCompletePageEntitesStandardOrder(int orderId) {
    List<PageEntity> pageEntities = [];

    for (int i = 0; i < 9; i++) {
      PageEntity pageEntity = PageEntity(
        pageNumber: (i + 1),
        orderId: orderId,
        width: 50,
        thickness: 12,
        amount: 12,
      );
      pageEntity.setId(_pageId);
      pageEntity.addLengths(
        _createCompleteLengthEntitiesStandardOrder(pageEntity.id),
      );

      pageEntities.add(pageEntity);
      _pageId++;
    }

    return pageEntities;
  }

  List<PageEntity> _createCompletePageEntitesExportOrder(int orderId) {}

  List<LengthEntity> _createCompleteLengthEntitiesStandardOrder(pageId) {}

  List<LengthEntity> _createCompleteLengthEntitiesExportOrder(pageId) {}

  OrderEntity _createOrderEntity(int clientId) {
    return OrderEntity(
      clientId: clientId,
      woodSpecie: woodSpecie,
      orderType: orderType,
      createDate: DateTime.now(),
      updateDate: DateTime.now(),
    );
  }
}
