import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_sem2/data/model/recomends_model.dart';

import '../../../data/datasource/recomends_datasource.dart';

part 'recomends_event.dart';
part 'recomends_state.dart';

class RecomendsBloc extends Bloc<RecomendsEvent, RecomendsState> {
  RecomendsBloc() : super(RecomendsInitial()) {
    on<OnGetRecomends>((event, emit) async  {
      emit(RecomendsLoading());
      final result = await RecomendsDatasource.getRecomends();
      if (result == null) {
        emit(RecomendsFailure('Gagal mendapatkan rekomendasi'));
      } else {
        emit(RecomendsLoaded(result));
      }
    });
  }
}
