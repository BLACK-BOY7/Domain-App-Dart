import '../entities/page_entity.dart';

abstract class PageRepository {
  Future<PageEntity> getByIdAsync(int id);

  Future<void> deleteAsync(PageEntity pageEntity);

  Future<void> insertAsync(PageEntity pageEntity);

  Future<void> updateAsync(PageEntity pageEntity);

  Future<List<PageEntity>> getAllPagesOrderAsync(int orderId);

  Future<void> deletePagesAsync(List<PageEntity> pageEntities);

  Future<void> insertPagesAsync(List<PageEntity> pageEntities);
}
