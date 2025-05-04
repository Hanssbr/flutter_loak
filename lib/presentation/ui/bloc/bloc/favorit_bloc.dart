import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_sem2/data/model/favorit_model.dart';

import '../../../../data/datasource/favorit_datasource.dart';

part 'favorit_event.dart';
part 'favorit_state.dart';

class FavoritBloc extends Bloc<FavoritEvent, FavoritState> {
  FavoritBloc() : super(FavoritInitial()) {
    on<LoadFavorit>((event, emit) async {
      emit(FavoritLoading());

      final result = await FavoritDatasource.getFavorits(event.token);

      if (result != null) {
        emit(FavoritLoaded(result));
      } else {
        emit(FavoritFailure('Gagal memuat data favorit'));
      }
    });
  }
}


