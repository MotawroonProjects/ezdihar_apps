part of 'sub_services_cubit.dart';
@immutable
abstract class SubServicesState {}

class Isloading extends SubServicesState {}
class OnDataSuccess extends SubServicesState {
  List<CategoryModel> list;
  OnDataSuccess(this.list);
}
class OnEror extends SubServicesState {
  String error;
  OnEror(this.error);
}
