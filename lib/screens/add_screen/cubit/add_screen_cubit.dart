import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_screen_state.dart';

class AddScreenCubit extends Cubit<AddScreenState> {
  int index = 0;
  AddScreenCubit() : super(OnPositionChangedState(pos: 0));

  void updatePos({required int pos}){
    index = pos;
    emit(OnPositionChangedState(pos: pos));
  }
}
