part of 'my_item_bloc.dart';

@immutable
sealed class MyItemEvent {}

class GetMyItems extends MyItemEvent {}

class DeleteMyItem extends MyItemEvent {
  final int itemId;
  DeleteMyItem(this.itemId);
}

class UpdateItemStatus extends MyItemEvent {
  final String itemId;
  final String status; // "available" or "unavailable"

  UpdateItemStatus({required this.itemId, required this.status});
}
