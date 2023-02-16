import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:flutter/material.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/screens/user/home_page/navigation_screens/home_screen/cubit/home_page_cubit.dart';
import 'package:meta/meta.dart';
import 'package:table_calendar/table_calendar.dart';

part 'main_page_state.dart';

class MainPageCubit extends Cubit<MainPageState> {
  CalendarFormat format = CalendarFormat.month;
  String filterType = AppConstant.mostPopular;
  DateTime focusedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String filterDate = 'all'.tr();
  String category_id = 'all'.tr();
  String num ='5';
  List<CategoryModel> categories = [];
  List<ProjectModel> projects = [];
  late CategoryModel selectedCategoryModel;
  late ServiceApi api;
  UserModel? userModel;

  MainPageCubit() : super(IsLoadingData(type: AppConstant.mostPopular)) {
    api = ServiceApi();
    getUserData();
    categories.add(CategoryModel.factory(0, 'all'.tr(), 'all'.tr(), ''));
    selectedCategoryModel = categories[0];
    getCategories();
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  void updateFilterType(String filterType) {
    this.filterType = filterType;

    getData();
  }

  void updateCalenderFormat(CalendarFormat format) {
    this.format = format;
    emit(CalenderFormatChanged(format));
  }

  void updateCalenderFocusedDate(DateTime focusedDate, DateTime selectedDate) {
    this.focusedDate = focusedDate;
    this.selectedDate = selectedDate;
    emit(CalenderFocusedDateChanged(focusedDate, selectedDate));
  }

  void OnDateSelected(DateTime selectedDate) {
    filterDate = DateFormat('yyyy-MM-dd','en').format(selectedDate);
    emit(CalenderOnDateSelected(selectedDate));
  }

  void updateFilterDate(String filterDate) {
    this.filterDate = filterDate;
    emit(CalenderOnDateFilterSelected(filterDate));
  }

  void getData() async {
    try {
      projects.clear();
      emit(IsLoadingData(type: this.filterType));
      UserModel model = await Preferences.instance.getUserModel();
      String user_id = '';
      if (model.user.isLoggedIn) {
        user_id = model.user.id.toString();
      }
      String date = 'all';
      if (filterDate == 'الكل') {
        date = "All";
      } else {
        date = filterDate;
      }
      ProjectsDataModel home = await api.getHomeData(
        user_id
      );
      if (home.status.code == 200) {

        projects = home.data;
        emit(OnDataSuccess(projects));
      } else {}
    } catch (e) {
      print("ldlldkdkkd${e.toString()}");
      emit(OnError(e.toString()));

    }
  }

  void getCategories() async {
    try {
      CategoryDataModel categoryDataModel = await api.getCategory();
      categories.addAll(categoryDataModel.data);
      emit(CategoryState(categories));
      getData();
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void updateSelectedCategory(CategoryModel categoryModel) {
    this.selectedCategoryModel = categoryModel;
    this.category_id = categoryModel.title_en;
    emit(OnCategorySelectedState(categoryModel));
  }

  void love_report_follow(
      int post_index, ProjectModel model, String type,BuildContext context) async {
    try {
      getUserData().then((value) async {
        if(value!.user.isLoggedIn){
          StatusResponse response =
          await api.love_follow_report(value!.access_token, model.id, type);
          if (response.code == 200) {
            model.action_user=type;
            updateProject(post_index, model);
          } else {}
        }else{
          Navigator.of(context).pushNamed(AppConstant.pageUserRoleRoute);
        }

      });
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void clearFilter() {
    selectedCategoryModel = categories[0];
    filterDate = 'all'.tr();
    category_id = 'all'.tr();
    emit(CalenderOnDateFilterSelected(filterDate));
    emit(OnCategorySelectedState(selectedCategoryModel));
    getData();
  }

  void loginFirst() {
    emit(OnLoginFirst());
  }

  void onErrorData(String error) {
    emit(OnError(error));
  }

  void updateProject(int index, ProjectModel model) {
    print('data=>${model.action_user}');
    projects[index] = model;
    emit(OnDataSuccess(projects));
  }

}
