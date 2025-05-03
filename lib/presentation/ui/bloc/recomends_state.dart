part of 'recomends_bloc.dart';

@immutable
sealed class RecomendsState {}

final class RecomendsInitial extends RecomendsState {}

final class RecomendsLoading extends RecomendsState {}

final class RecomendsFailure extends RecomendsState {
  final String message;
  RecomendsFailure(this.message);
}

final class RecomendsLoaded extends RecomendsState {
  final List<RecomendItems> recomendsItems;
  RecomendsLoaded(this.recomendsItems);
}


