part of 'send_general_study_cubit.dart';

@immutable
abstract class SendGeneralStudyState {}

class SendGeneralStudyInitial extends SendGeneralStudyState {}
class OnDataValid extends SendGeneralStudyState {}
class OnShowProjectInvestmentChanged extends SendGeneralStudyState {
  bool isChecked;
  OnShowProjectInvestmentChanged(this.isChecked);
}