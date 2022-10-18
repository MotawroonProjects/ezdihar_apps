part of 'consultants_cubit.dart';

@immutable
abstract class ConsultantsState {}

class IsLoading extends ConsultantsState {}
class OnDataSuccess extends ConsultantsState {
  List<User> data;
  OnDataSuccess(this.data);
}
class OnError extends ConsultantsState {
  String error;
  OnError(this.error);
}
