import 'package:main/domain/enums/order_type.dart';

import 'package:main/domain/entities/client_entity.dart';
import 'package:main/domain/entities/length_entity.dart';
import 'package:main/domain/entities/order_entity.dart';
import 'package:main/domain/entities/page_entity.dart';

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
    ClientEntity clientEntity = ClientEntity(name: clientName);
    clientEntity.setId(1);

    OrderEntity orderEntity = _createOrderEntity(clientEntity.id);
    orderEntity.setId(1);

    orderEntity.addClientEntity(clientEntity);
    orderEntity.addPages(
      _createCompletePageEntitesStandardOrder(orderEntity.id),
    );

    return orderEntity;
  }

  OrderEntity _createExportOrderEntity() {
    ClientEntity clientEntity = ClientEntity(name: clientName);
    clientEntity.setId(1);

    OrderEntity orderEntity = _createOrderEntity(clientEntity.id);
    orderEntity.setId(1);

    orderEntity.addClientEntity(clientEntity);
    orderEntity.addPages(_createCompletePageEntitesExportOrder(orderEntity.id));

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

  List<PageEntity> _createCompletePageEntitesExportOrder(int orderId) {
    List<PageEntity> pageEntities = [];

    for (int i = 0; i < 9; i++) {
      PageEntity pageEntity = PageEntity(
        pageNumber: (i + 1),
        orderId: orderId,
        width: 24,
        thickness: 113,
        amount: 0,
      );
      pageEntity.setId(_pageId);
      pageEntity.addLengths(
        _createCompleteLengthEntitiesExportOrder(pageEntity.id),
      );

      pageEntities.add(pageEntity);
      _pageId++;
    }

    return pageEntities;
  }

  List<LengthEntity> _createCompleteLengthEntitiesStandardOrder(int pageId) {
    List<LengthEntity> lengthEntites = [];
    int lengthSize = 2500;

    for (int i = 0; i < 16; i++) {
      LengthEntity lengthEntity = LengthEntity(
        pageId: pageId,
        lengthSize: lengthSize,
        registryIndex: i,
        currentAmount: 999,
        desiredAmount: 999,
      );
      lengthEntity.setId(_lengthId);
      lengthEntites.add(lengthEntity);
      lengthSize += 500;
      
      _lengthId++;
    }

    return lengthEntites;
  }

  List<LengthEntity> _createCompleteLengthEntitiesExportOrder(int pageId) {
    List<LengthEntity> lengthEntites = [];

    int lengthSize = 6000;

    for (int i = 0; i < 17; i++) {
      LengthEntity lengthEntity = LengthEntity(
        pageId: pageId,
        lengthSize: lengthSize,
        registryIndex: i,
        currentAmount: 999,
        desiredAmount: 999,
      );
      lengthEntity.setId(_lengthId);
      lengthEntites.add(lengthEntity);
      lengthSize += 1000;

      _lengthId++;
    }

    return lengthEntites;
  }

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
