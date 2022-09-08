part of 'consultant_details_cubit.dart';

@immutable
abstract class ConsultantDetailsState {}

class IsLoading extends ConsultantDetailsState {}

class OnDataSuccess extends ConsultantDetailsState {
  UserModel model;
  OnDataSuccess(this.model);
}
class OnError extends ConsultantDetailsState {
  String error;
  OnError(this.error);
}
