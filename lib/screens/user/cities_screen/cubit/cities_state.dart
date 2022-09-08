part of 'cities_cubit.dart';

@immutable
abstract class CitiesState {}

class IsLoading extends CitiesState {}

class OnDataSuccess extends CitiesState {
  List<CityModel> data;
  OnDataSuccess(this.data);
}

class OnError extends CitiesState {
  String error;

  OnError(this.error);
}
