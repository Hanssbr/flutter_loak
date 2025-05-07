part of 'create_item_bloc.dart';

@immutable
sealed class CreateItemEvent {}

class CreateEvent extends CreateItemEvent {
  final String name;
  final String description;
  final String category;
  final String condition;
  final String location;
  final dynamic photo;
  final String token;

  CreateEvent({
    required this.name,
    required this.description,
    required this.category,
    required this.condition,
    required this.location,
    required this.photo,
    required this.token,
  });
}
