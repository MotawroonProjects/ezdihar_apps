part of 'main_page_cubit.dart';

@immutable
abstract class MainPageState {}

class IsLoadingData extends MainPageState {
  String type;

  IsLoadingData({required this.type});
}

class CalenderFormatChanged extends MainPageState {
  CalendarFormat format;

  CalenderFormatChanged(this.format);
}

class CalenderFocusedDateChanged extends MainPageState {
  DateTime focusedDate;
  DateTime selectedDate;

  CalenderFocusedDateChanged(this.focusedDate, this.selectedDate);
}

class CalenderOnDateSelected extends MainPageState {
  DateTime selectedDate;

  CalenderOnDateSelected(this.selectedDate);
}

class CalenderOnDateFilterSelected extends MainPageState {
  String filterDate;

  CalenderOnDateFilterSelected(this.filterDate);
}

class CategoryState extends MainPageState {
  List<CategoryModel> categories;

  CategoryState(this.categories);
}

class OnCategorySelectedState extends MainPageState {
  CategoryModel categoryModel;

  OnCategorySelectedState(this.categoryModel);
}

class OnDataSuccess extends MainPageState {
  List<ProjectModel> list;

  OnDataSuccess(this.list);
}

class OnLoginFirst extends MainPageState {
  OnLoginFirst();
}
class OnError extends MainPageState {
  String error;
  OnError(this.error);
}
