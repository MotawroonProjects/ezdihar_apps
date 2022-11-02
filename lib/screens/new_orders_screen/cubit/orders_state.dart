part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class IsLoading extends OrdersState {}

class OnDataSuccess extends OrdersState {
  List<ProviderOrder> data;
  OnDataSuccess(this.data);
}

class OnError extends OrdersState {
  String error;

  OnError(this.error);
}
