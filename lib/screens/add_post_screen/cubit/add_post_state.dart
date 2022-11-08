part of 'add_post_cubit.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}
class IsLoading extends AddPostState{

}
class OnDataValid extends AddPostState {
  bool valid;

  OnDataValid(this.valid);

}
class OnShowProjectInvestmentChanged extends AddPostState {
  bool isChecked;
  OnShowProjectInvestmentChanged(this.isChecked);
}
class OnDataError extends AddPostState{
  String error;
  OnDataError(this.error);
}
class OnCategorySuccess extends AddPostState{
  List<CategoryModel> list;
  OnCategorySuccess(this.list);
}
class PhotoPicked extends AddPostState {
  String imagePath;

  PhotoPicked(this.imagePath);
}
class OnAddedSuccess extends AddPostState{

}