part of 'add_report_cubit.dart';

@immutable
abstract class AddReportState {}

class AddReportInitial extends AddReportState {}
class IsLoading extends AddReportState{

}
class OnDataValid extends AddReportState {
  bool valid;

  OnDataValid(this.valid);

}
class OnShowProjectInvestmentChanged extends AddReportState {
  bool isChecked;
  OnShowProjectInvestmentChanged(this.isChecked);
}
class OnDataError extends AddReportState{
  String error;
  OnDataError(this.error);
}

class PhotoPicked extends AddReportState {
  String imagePath;

  PhotoPicked(this.imagePath);
}
class OnAddedSuccess extends AddReportState{

}