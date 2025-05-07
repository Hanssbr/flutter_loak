part of 'create_item_bloc.dart';

@immutable
sealed class CreateItemState {}

class CreateItemInitial extends CreateItemState {}

class CreateItemLoading extends CreateItemState {}

class CreateItemSuccess extends CreateItemState {}

class CreateItemError extends CreateItemState {
  final String message;

  CreateItemError(this.message);
}
