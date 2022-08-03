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

class OnDataSuccess extends UserProfileState {
  List<ProjectModel> list;

  OnDataSuccess(this.list);
}

class OnPostsSuccess extends UserProfileState {
  List<ProjectModel> list;

  OnPostsSuccess(this.list);
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
