part of 'my_item_bloc.dart';

@immutable
sealed class MyItemEvent {}

class GetMyItems extends MyItemEvent {}

class DeleteMyItem extends MyItemEvent {
  final int itemId;
  DeleteMyItem(this.itemId);
}


