import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasource/createitems_datasource.dart';
import '../../data/model/item_model.dart';

part 'create_item_event.dart';
part 'create_item_state.dart';

class CreateItemBloc extends Bloc<CreateItemEvent, CreateItemState> {
  CreateItemBloc() : super(CreateItemInitial()) {
    on<CreateEvent>((event, emit) async {
      emit(CreateItemLoading());

      final item = Items(
        userId: event.token,
        name: event.name,
        description: event.description,
        category: event.category,
        condition: event.condition,
        location: event.location,
        photo: null, 
        id: 0,
      );

      final success = await CreateitemsDatasource.createItem(item, event.photo, event.token);


      if (success) {
        emit(CreateItemSuccess());
      } else {
        emit(CreateItemError("Failed to create item."));
      }
    });
  }
}

