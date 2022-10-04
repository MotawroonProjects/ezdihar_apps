part of 'orders_cubit.dart';

abstract class OrdersState{}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}
class OrdersLoaded extends OrdersState {
  final MainOrdersModel providerOrder;

  OrdersLoaded(this.providerOrder);
}

class OrdersTabChanged extends OrdersState {
  final int index;

  OrdersTabChanged(this.index);
}

class UserDataDone extends OrdersState {}

class OrderChangeStatusLoading extends OrdersState {}
class OrderChangeStatusDone extends OrdersState {
  final StatusResponse statusResponse;

  OrderChangeStatusDone(this.statusResponse);
}
class OrderChangeStatusError extends OrdersState {}
