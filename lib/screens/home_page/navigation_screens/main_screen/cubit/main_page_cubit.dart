import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/home_screen/cubit/home_page_cubit.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'main_page_state.dart';


class MainPageCubit extends Cubit<MainPageState> {
  CalendarFormat format = CalendarFormat.month;
  String filterType = AppConstant.mostPopular;
  DateTime focusedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String filterDate = '';

  MainPageCubit() : super(IsLoadingData(type: AppConstant.mostPopular));



  void updateFilterType(String filterType){
    this.filterType = filterType;
    emit(IsLoadingData(type: filterType));

  }
  void updateCalenderFormat(CalendarFormat format){
    this.format = format;
    emit(CalenderFormatChanged(format));

  }
  void updateCalenderFocusedDate(DateTime focusedDate,DateTime selectedDate){
    this.focusedDate = focusedDate;
    this.selectedDate = selectedDate;
    emit(CalenderFocusedDateChanged(focusedDate,selectedDate));

  }
  void OnDateSelected(DateTime selectedDate){
    filterDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    emit(CalenderOnDateSelected(selectedDate));

  }

  void updateFilterDate(String filterDate){
    this.filterDate = filterDate;
    emit(CalenderOnDateFilterSelected(filterDate));

  }

  void getData(){
    emit(IsLoadingData(type: this.filterType));
    print("Getting data....");
  }
}
