part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class IsLoadingData extends FavoriteState {
}

class OnDataSuccess extends FavoriteState {
  List<ProjectModel> list;

  OnDataSuccess(this.list);
}

class OnRemoveFavorite extends FavoriteState {

}

class OnError extends FavoriteState {
  String error;
  OnError(this.error);
}

