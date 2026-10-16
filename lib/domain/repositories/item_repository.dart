import '../entities/item_entity.dart';

abstract class ItemRepository {
  Future<List<ItemEntity>> getItems();
}
