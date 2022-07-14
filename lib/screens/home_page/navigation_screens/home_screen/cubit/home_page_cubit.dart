import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  int index = 0;
  HomePageCubit() : super(MainPageInitial(0));

  void updateIndex(int index){
    this.index = index;
    emit(MainPageIndexUpdated(index));
  }
}
