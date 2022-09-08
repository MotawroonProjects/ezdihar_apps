part of 'investment_cubit.dart';

@immutable
abstract class InvestmentState {}

class IsCategoryLoading extends InvestmentState {}

class OnProjectsDataSuccess extends InvestmentState {
  List<ProjectModel> projects;
  OnProjectsDataSuccess(this.projects);
}
class OnError extends InvestmentState{
  String error;
  OnError(this.error);
}