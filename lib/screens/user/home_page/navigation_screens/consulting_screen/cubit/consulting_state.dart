part of 'consulting_cubit.dart';

@immutable
abstract class ConsultingState {}


class IsLoading extends ConsultingState{

}

class OnDataSuccess extends ConsultingState{
  List<ConsultantTypeModel> list;
  OnDataSuccess(this.list);
}

class OnError extends ConsultingState {
  String error;
  OnError(this.error);
}
