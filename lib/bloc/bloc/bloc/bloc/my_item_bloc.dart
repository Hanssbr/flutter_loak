import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_sem2/data/model/myitem_model.dart';

import '../../../../data/datasource/myitem_datasource.dart';

part 'my_item_event.dart';
part 'my_item_state.dart';

class MyItemBloc extends Bloc<MyItemEvent, MyItemState> {
  MyItemBloc() : super(MyItemInitial()) {
    on<MyItemEvent>((event, emit) async {
      emit(MyItemLoading());
      final result = await MyItemDatasource.getMyItems();
      if (result == null) {
        emit(MyItemFailure('Tidak ada item yang dimiliki.'));
      } else {
        emit(MyItemLoaded(result));
      }
    });

    on<DeleteMyItem>((event, emit) async {
      emit(MyItemLoading());
      final success = await MyItemDatasource.deleteMyItem(event.itemId);

      if (success) {
        // Setelah hapus, ambil ulang list terbaru
        final result = await MyItemDatasource.getMyItems();
        if (result == null) {
          emit(
            MyItemFailure('Item berhasil dihapus, tapi gagal memuat ulang.'),
          );
        } else {
          emit(MyItemLoaded(result));
        }
      } else {
        emit(MyItemFailure('Gagal menghapus item.'));
      }
    });
  }
}
