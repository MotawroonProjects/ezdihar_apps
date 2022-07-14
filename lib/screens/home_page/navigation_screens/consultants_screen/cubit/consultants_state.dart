part of 'consultants_cubit.dart';

@immutable
abstract class ConsultantsState {}

class OnPagePosChangedState extends ConsultantsState {
  int index;
  OnPagePosChangedState(this.index);
}
