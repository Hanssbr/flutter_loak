part of 'get_item_bloc.dart';

@immutable
sealed class GetItemEvent {}


class OnGetItem extends GetItemEvent {}

class SearchItem extends GetItemEvent {
  final String? keyword;
  SearchItem({this.keyword});
}