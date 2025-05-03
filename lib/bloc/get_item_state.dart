part of 'get_item_bloc.dart';



@immutable
sealed class GetItemState {}

final class GetItemInitial extends GetItemState {}

final class GetItemLoading extends GetItemState {}

final class GetItemFailure extends GetItemState {
  final String message;

  GetItemFailure(this.message);
}

final class GetItemLoaded extends GetItemState {
  final List<Items> items;

  GetItemLoaded(this.items);
}