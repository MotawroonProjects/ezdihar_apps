part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UpdateIndex extends UserProfileState {
  int index;
  UpdateIndex(this.index);
}

class IsLoadingData extends UserProfileState {
}
class IsLoadingPosts extends UserProfileState {
}

class OnFavDataSuccess extends UserProfileState {
  List<ProjectModel> list;

  OnFavDataSuccess(this.list);
}

class OnMyPostsSuccess extends UserProfileState {
  List<ProjectModel> list;

  OnMyPostsSuccess(this.list);
}
class OnSavedPostsSuccess extends UserProfileState {
  List<ProjectModel> list;

  OnSavedPostsSuccess(this.list);
}
class OnRemoveFavorite extends UserProfileState {

}

class OnUserDataGet extends UserProfileState{
  UserModel userModel;
  OnUserDataGet(this.userModel);
}

class OnError extends UserProfileState {
  String error;
  OnError(this.error);
}
class OnErrorPosts extends UserProfileState {
  String error;
  OnErrorPosts(this.error);
}
