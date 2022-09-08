part of 'provider_details_cubit.dart';

@immutable
abstract class ProviderDetailsState {}

class IsLoading extends ProviderDetailsState {}

class OnDataSuccess extends ProviderDetailsState {
  UserModel model;
  OnDataSuccess(this.model);
}
class OnError extends ProviderDetailsState {
  String error;
  OnError(this.error);
}
