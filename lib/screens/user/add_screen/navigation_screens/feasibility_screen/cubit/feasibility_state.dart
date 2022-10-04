part of 'feasibility_cubit.dart';

@immutable
abstract class FeasibilityState {}

class IsCategoryLoading extends FeasibilityState {}

class OnCategoryDataSuccess extends FeasibilityState {
  List<CategoryModel> categories;
  OnCategoryDataSuccess(this.categories);
}
class OnError extends FeasibilityState{
  String error;
  OnError(this.error);
}
