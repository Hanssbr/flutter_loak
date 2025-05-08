part of 'item_details_bloc.dart';

@immutable
sealed class ItemDetailsState {}

final class ItemDetailsInitial extends ItemDetailsState {}

final class ItemDetailsLoading extends ItemDetailsState {}

final class ItemDetailsLoaded extends ItemDetailsState {
  final Items item;
  ItemDetailsLoaded(this.item);
}

final class ItemDetailsFailure extends ItemDetailsState {
  final String message;
  ItemDetailsFailure(this.message);
}
