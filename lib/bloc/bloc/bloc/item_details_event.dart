part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class Getdetails extends ItemDetailsEvent {
  final int id;
  Getdetails(this.id);
}

class UpdateItemStatus extends ItemDetailsEvent {
  final int itemId;
  final String newStatus;

  UpdateItemStatus(this.itemId, this.newStatus); // Pastikan ini seperti ini
}

