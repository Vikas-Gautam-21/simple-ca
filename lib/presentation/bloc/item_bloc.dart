import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_items_usecase.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItemsUseCase getItemsUseCase;

  ItemBloc({required this.getItemsUseCase}) : super(ItemInitial()) {
    on<FetchItems>(_onFetchItems);
  }

  Future<void> _onFetchItems(FetchItems event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    try {
      final items = await getItemsUseCase();
      emit(ItemLoaded(items));
    } catch (e) {
      emit(ItemError(e.toString()));
    }
  }
}
