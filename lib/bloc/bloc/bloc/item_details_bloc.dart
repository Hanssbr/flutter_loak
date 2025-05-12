import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_sem2/data/model/item_model.dart';

import '../../../data/datasource/item_datasource.dart';

part 'item_details_event.dart';
part 'item_details_state.dart';

class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ItemDetailsBloc() : super(ItemDetailsInitial()) {
    on<Getdetails>(_onGetDetails);
    on<UpdateItemStatus>(_onUpdateItemStatus);
  }

  Future<void> _onGetDetails(
    Getdetails event,
    Emitter<ItemDetailsState> emit,
  ) async {
    emit(ItemDetailsLoading());

    try {
      final item = await ItemsSource().itemDetails(event.id);

      if (item != null) {
        emit(ItemDetailsLoaded(item));
      } else {
        emit(ItemDetailsFailure('Item tidak ditemukan.'));
      }
    } catch (e) {
      emit(ItemDetailsFailure('Terjadi kesalahan: $e'));
    }
  }

  Future<void> _onUpdateItemStatus(
    UpdateItemStatus event,
    Emitter<ItemDetailsState> emit,
  ) async {
    emit(ItemStatusUpdating());
    try {
      final updatedItem = await ItemsSource().updateItemStatus(
        event.itemId,
        event.newStatus,
      );
      emit(ItemDetailsLoaded(updatedItem));
    } catch (e) {
      emit(ItemDetailsFailure('Gagal mengubah status: $e'));
    }
  }
}
