part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
final class FavouriteLoading extends FavouriteState {}
final class FavouriteScuess extends FavouriteState {}
final class FavouriteFialure extends FavouriteState {}
final class FavouriteCahngeIcon extends FavouriteState {}

final class FavouriteLoadingFvList extends FavouriteState {}
final class FavouriteScuessFvList extends FavouriteState {}
final class FavouriteFialureFvList extends FavouriteState {}

final class FavouriteScuessInsert extends FavouriteState {}

final class FavouriteScuessRemove extends FavouriteState {}
