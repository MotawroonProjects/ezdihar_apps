part of 'user_order_cubit.dart';

@immutable
abstract class UserOrderState {}

class UpdateIndex extends UserOrderState {
  int index;
  UpdateIndex(this.index);
}

class IsLoadingData extends UserOrderState {
}


class OnCurrentDataSuccess extends UserOrderState {
  MainOrdersModel list;

  OnCurrentDataSuccess(this.list);
}

class OnPreviousDataSuccess extends UserOrderState {
  MainOrdersModel list;

  OnPreviousDataSuccess(this.list);
}





class OnError extends UserOrderState {
  String error;
  OnError(this.error);
}
