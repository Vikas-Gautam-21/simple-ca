import '../entities/item_entity.dart';
import '../repositories/item_repository.dart';

class GetItemsUseCase {
  final ItemRepository repository;

  GetItemsUseCase(this.repository);

  Future<List<ItemEntity>> call() async {
    return await repository.getItems();
  }
}
