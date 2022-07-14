part of 'add_screen_cubit.dart';

@immutable
abstract class AddScreenState {}

class OnPositionChangedState extends AddScreenState {
  int pos;
  OnPositionChangedState({required this.pos});
}
