part of 'send_general_study_cubit.dart';

@immutable
abstract class SendGeneralStudyState {}

class SendGeneralStudyInitial extends SendGeneralStudyState {}
class IsLoading extends SendGeneralStudyState{

}
class OnDataValid extends SendGeneralStudyState {}
class OnShowProjectInvestmentChanged extends SendGeneralStudyState {
  bool isChecked;
  OnShowProjectInvestmentChanged(this.isChecked);
}
class OnDataError extends SendGeneralStudyState{
  String error;
  OnDataError(this.error);
}
class OnConsultantTypesSuccess extends SendGeneralStudyState{
  List<ConsultantTypeModel> list;
  OnConsultantTypesSuccess(this.list);
}
class PhotoPicked extends SendGeneralStudyState {
  String imagePath;

  PhotoPicked(this.imagePath);
}
class OnAddedSuccess extends SendGeneralStudyState{

}