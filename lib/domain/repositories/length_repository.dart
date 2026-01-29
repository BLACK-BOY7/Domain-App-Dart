import '../entities/length_entity.dart';

abstract class LengthRepository {
  Future<LengthEntity> getByIdAsync(int id);

  Future<void> deleteAsync(LengthEntity lengthEntity);

  Future<void> insertAsync(LengthEntity lengthEntity);

  Future<void> updateAsync(LengthEntity lengthEntity);

  Future<List<LengthEntity>> getAllLengthsByPageId(int pageId);

  Future<void> deleteAllLengthEntities(List<LengthEntity> lengthEntities);
}
