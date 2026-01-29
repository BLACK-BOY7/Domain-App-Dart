import '../entities/order_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> getByIdAsync(int id);

  Future<void> deleteAsync(OrderEntity orderEntity);

  Future<void> insertAsync(OrderEntity orderEntity);

  Future<void> updateAsync(OrderEntity orderEntity);
}
