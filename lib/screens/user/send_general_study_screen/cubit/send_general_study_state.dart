part of 'send_general_study_cubit.dart';

@immutable
abstract class SendGeneralStudyState {}

class SendGeneralStudyInitial extends SendGeneralStudyState {}
class IsLoading extends SendGeneralStudyState{

}
class OnDataValid extends SendGeneralStudyState {
  bool valid;

  OnDataValid(this.valid);

}
class OnShowProjectInvestmentChanged extends SendGeneralStudyState {
  bool isChecked;
  OnShowProjectInvestmentChanged(this.isChecked);
}
class OnDataError extends SendGeneralStudyState{
  String error;
  OnDataError(this.error);
}
class OnCategorySuccess extends SendGeneralStudyState{
  List<CategoryModel> list;
  OnCategorySuccess(this.list);
}
class PhotoPicked extends SendGeneralStudyState {
  String imagePath;

  PhotoPicked(this.imagePath);
}
class OnAddedSuccess extends SendGeneralStudyState{

}