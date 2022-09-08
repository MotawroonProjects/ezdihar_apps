part of 'add_screen_cubit.dart';

@immutable
abstract class AddScreenState {}

class OnPositionChangedState extends AddScreenState {
  int pos;

  OnPositionChangedState({required this.pos});
}

class OnSliderDataSuccess extends AddScreenState {
  List<String> sliders;

  OnSliderDataSuccess(this.sliders);
}

class OnError extends AddScreenState {
  String error;

  OnError(this.error);
}
