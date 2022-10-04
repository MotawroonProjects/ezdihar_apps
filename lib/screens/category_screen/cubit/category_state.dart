part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class IsLoading extends CategoryState {}

class OnDataSuccess extends CategoryState {
  List<CategoryModel> data;
  OnDataSuccess(this.data);
}

class OnError extends CategoryState {
  String error;

  OnError(this.error);
}
