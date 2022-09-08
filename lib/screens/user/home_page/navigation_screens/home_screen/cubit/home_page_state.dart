part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class MainPageInitial extends HomePageState {
  int index = 0;
  MainPageInitial(this.index);
}

class MainPageIndexUpdated extends HomePageState {
  int index;
  MainPageIndexUpdated(this.index) ;

}
