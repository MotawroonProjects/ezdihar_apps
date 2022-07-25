import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/widgets/main_page_widgets.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:table_calendar/table_calendar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _colorAnimation =
        ColorTween(begin: AppColors.grey1, end: AppColors.colorPrimary)
            .animate(_controller);

    _scaleAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem(
          tween: Tween<double>(begin: 24.0, end: 30.0), weight: 30.0),
      TweenSequenceItem(
          tween: Tween<double>(begin: 30.0, end: 24.0), weight: 24.0)
    ]).animate(_controller);

    _controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<MainPageCubit, MainPageState>(
      listener: (context, state) {
        if(state is OnLoginFirst){
          AlertController.show('warning'.tr(), 'signin_signup'.tr(),TypeAlert.warning);
        }else if(state is OnError){
          AlertController.show('warning'.tr(),state.error,TypeAlert.warning);

        }
      },
      child: Column(children: [_buildFilterSection(), _buildListView()]),
    ));
  }

  Widget _buildFilterSection() {
    double width = MediaQuery.of(context).size.width;
    double height = 56.0;
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    String filterType = cubit.filterType;

    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      width: width,
      height: height,
      color: AppColors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
                onTap: () => showFilterSheet(),
                child: AppWidget.svg("filter.svg", AppColors.color1, 24, 24)),
          ),
          Expanded(
            child: BlocBuilder<MainPageCubit, MainPageState>(
              builder: (context, state) {
                if (state is IsLoadingData) {
                  filterType = state.type;
                }
                return MaterialButton(
                    textColor: filterType == AppConstant.mostPopular
                        ? AppColors.colorPrimary
                        : AppColors.grey1,
                    onPressed: () {
                      if (cubit.filterType != AppConstant.mostPopular) {
                        cubit.updateFilterType(AppConstant.mostPopular);
                      }
                    },
                    child: Text('mostPopular'.tr(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)));
              },
            ),
          ),
          SizedBox(
            width: 1,
            height: 36,
            child: Container(
              color: AppColors.black,
            ),
          ),
          Expanded(
            child: BlocBuilder<MainPageCubit, MainPageState>(
              builder: (context, state) {
                if (state is IsLoadingData) {
                  filterType = state.type;
                }
                return MaterialButton(
                    textColor: filterType == AppConstant.following
                        ? AppColors.colorPrimary
                        : AppColors.grey1,
                    onPressed: () {
                      if (cubit.filterType != AppConstant.following) {
                        cubit.updateFilterType(AppConstant.following);
                      }
                    },
                    child: Text(
                      'following'.tr(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MainPageCubit, MainPageState>(
        builder: (context, state) {
          if (state is IsLoadingData) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ),
              ),
            );
          }else if(state is OnError){
            return Container();
          } else {
            List<ProjectModel> list = cubit.projects;

            if (list.length > 0) {
              return Expanded(
                  child: RefreshIndicator(
                color: AppColors.colorPrimary,
                onRefresh: refreshData,
                child: ListView.builder(
                    itemCount: list.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ProjectModel model = list[index];
                      return MainPageWidgets().buildProjectRow(
                          context,
                          model,
                          index,
                          addRemoveFavorite,
                          navigateToProjectDetails,
                          showSheet,
                          _colorAnimation,
                          _scaleAnimation,
                          _controller);
                    }),
              ));
            } else {
              return Expanded(
                  child: Center(
                child: Text(
                  'no_projects'.tr(),
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                ),
              ));
            }
          }
        },
      ),
    );
  }

  Future<void> refreshData() async {
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    cubit.getData();
  }

  void addRemoveFavorite(ProjectModel model, int index) {
    _controller.forward();
  }

  void navigateToProjectDetails(ProjectModel model, int index) {}

  void showSheet(BuildContext context, ProjectModel model, int index) {
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        elevation: 8.0,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0))),
        context: context,
        builder: (context) {
          return MainPageWidgets().buildSheet(
              context: context,
              index: index,
              model: model,
              cubit: cubit,
              onTaped: _onBottomSheetTaped);
        });
  }

  void showFilterSheet() {
    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        elevation: 8.0,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0))),
        context: context,
        builder: (_) {
          return MainPageWidgets().buildFilterSheet(
              context: context,
              cubit: BlocProvider.of<MainPageCubit>(context),
              onTapped: showDialogCalender);
        });
  }

  void showDialogCalender() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: buildCalender(context),
          );
        });
  }

  Widget buildCalender(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MainPageCubit cubit = BlocProvider.of<MainPageCubit>(context);
    CalendarFormat format = cubit.format;
    Locale locale = EasyLocalization.of(context)!.locale;
    return Container(
        width: width,
        height: height * .65,
        child: BlocProvider.value(
          value: cubit,
          child: BlocBuilder<MainPageCubit, MainPageState>(
            builder: (context, state) {
              DateTime focusedDate = cubit.focusedDate;
              DateTime selectedDate = cubit.selectedDate;

              if (state is CalenderFormatChanged) {
                format = state.format;
              } else if (state is CalenderFocusedDateChanged) {
                focusedDate = state.focusedDate;
                selectedDate = state.selectedDate;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TableCalendar(
                      calendarFormat: format,
                      focusedDay: focusedDate,
                      locale: locale.languageCode,
                      firstDay: DateTime.now(),
                      lastDay: DateTime(DateTime.now().year + 100),
                      calendarStyle: CalendarStyle(
                        isTodayHighlighted: true,
                        todayDecoration: BoxDecoration(
                            color: AppColors.colorPrimary.withOpacity(.2),
                            shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                            color: AppColors.colorPrimary,
                            shape: BoxShape.circle),
                      ),
                      onFormatChanged: (format) {
                        cubit.updateCalenderFormat(format);
                      },
                      daysOfWeekHeight: 48.0,
                      onDaySelected: (selectedDate, focusedDate) {
                        cubit.updateCalenderFocusedDate(
                            focusedDate, selectedDate);
                      },
                      selectedDayPredicate: (date) {
                        return isSameDay(selectedDate, date);
                      },
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            cubit.OnDateSelected(cubit.selectedDate);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'select'.tr(),
                            style: TextStyle(
                                fontSize: 18.0, color: AppColors.colorPrimary),
                          )),
                      const SizedBox(
                        width: 24.0,
                      ),
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'cancel'.tr(),
                            style: TextStyle(
                                fontSize: 18.0, color: AppColors.grey6),
                          )),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }

  void _onBottomSheetTaped(
      {required ProjectModel model,
      required int index,
      required String action}) {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
