import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_sem2/data/datasource/item_datasource.dart';
import 'package:project_sem2/data/model/item_model.dart';

part 'get_item_event.dart';
part 'get_item_state.dart';

class GetItemBloc extends Bloc<GetItemEvent, GetItemState> {
  GetItemBloc() : super(GetItemInitial()) {
    on<OnGetItem>((event, emit) async {
      emit(GetItemLoading());
      final result = await ItemsSource.getItems();
      if (result == null) {
        emit(GetItemFailure('Data tidak di temukan'));
      } else {
        emit(GetItemLoaded(result));
      }
    });

    on<SearchItem>((event, emit) async {
      emit(GetItemLoading());
      final result = await ItemsSource.getItems(); // pakai source yang sama
      if (result == null) {
        emit(GetItemFailure('Data tidak ditemukan'));
      } else {
        final filtered =
            (event.keyword?.isNotEmpty ?? false)
                ? result.where((item) {
                  final name = item.name?.toLowerCase() ?? '';
                  final desc = item.description?.toLowerCase() ?? '';
                  final keyword = event.keyword!.toLowerCase();
                  return name.contains(keyword) || desc.contains(keyword);
                }).toList()
                : result;
        emit(GetItemLoaded(filtered));
      }
    });
  }
}
