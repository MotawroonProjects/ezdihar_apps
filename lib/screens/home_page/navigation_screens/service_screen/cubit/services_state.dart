part of 'services_cubit.dart';

@immutable
abstract class ServicesState {}

class IsLoading extends ServicesState {}
class OnDataSuccess extends ServicesState {
  List<CategoryModel> list;
  OnDataSuccess(this.list);
}
class OnError extends ServicesState {
  String error;
  OnError(this.error);
}
