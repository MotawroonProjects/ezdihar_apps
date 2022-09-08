import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'consultants_state.dart';

class ConsultantsCubit extends Cubit<ConsultantsState> {
  int index = 0;
  ConsultantsCubit() : super(OnPagePosChangedState(0));

  void updatePagePos(int index){
    this.index = index;
    emit(OnPagePosChangedState(index));
  }
}
