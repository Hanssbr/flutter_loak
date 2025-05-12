part of 'my_item_bloc.dart';

@immutable
sealed class MyItemState {}

final class MyItemInitial extends MyItemState {}

final class MyItemLoading extends MyItemState {}

final class MyItemFailure extends MyItemState {
  final String message;

  MyItemFailure(this.message);
}

final class MyItemLoaded extends MyItemState {
  final List<MyItems> myitems;

  MyItemLoaded(this.myitems);
}




