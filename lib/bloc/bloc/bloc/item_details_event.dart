part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsEvent {}

class Getdetails extends ItemDetailsEvent {
  final int id;
  Getdetails(this.id);
}


