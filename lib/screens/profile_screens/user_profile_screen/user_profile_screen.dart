import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/routes/app_routes.dart';
import 'package:ezdihar_apps/screens/profile_screens/user_profile_screen/cubit/user_profile_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/snackbar_method.dart';
import '../../../models/login_model.dart';
import '../../../preferences/preferences.dart';
import '../../user/home_page/navigation_screens/more_screen/cubit/more_cubit.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  // List<Widget> _tabs = [];
  List<Widget> _screens = [];

  late UserProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    //  _tabs = [
    //   // buildTab('my_posts'.tr(), 'post.svg', 0),
    //    buildTab('love'.tr(), 'empty_love.svg', 0),
    // //   buildTab('saved'.tr(), 'empty_love.svg', 2)
    //  ];
    _screens = [
      //buildMyPostList(),

      buildMyFavoriteList(),
      //  buildSavedPostList()
    ];
    //_controller = TabController(length: _tabs.length, vsync: this);

    return Scaffold(
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {

          if (state is IsDeleteAccountNotFound) {
            Future.delayed(Duration(milliseconds: 300), () {
              snackBar('user_not_found'.tr(), context, color: AppColors.red);
            });
          }
          if (state is IsDeleteAccountLoading) {
            return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ));
          }
          if (state is IsDeleteAccountError) {
            Future.delayed(Duration(milliseconds: 300), () {
              snackBar('error_occurred_try_again_later'.tr(), context,
                  color: AppColors.red);
            });
          }
          if (state is IsDeleteAccountLoaded) {
            Future.delayed(Duration(milliseconds: 300), () {
              snackBar('delete_profile_successfully'.tr(), context,
                  color: AppColors.red);
            });
            Future.delayed(Duration(milliseconds: 600), () {
              Preferences.instance.clearUserData();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppConstant.pageUserRoleRoute,
                  ModalRoute.withName(AppConstant.pageSplashRoute));
            });
            return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colorPrimary,
                ));
          }

          return Container(
            color: AppColors.grey3,
            child: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      leading: AppWidget.buildBackArrow(context: context),
                      title: Text(
                        'myProfile'.tr(),
                        style:
                        TextStyle(color: AppColors.black, fontSize: 16.0),
                      ),
                      expandedHeight: 330,
                      pinned: true,
                      centerTitle: true,
                      backgroundColor: AppColors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: header(),
                      ),
                    )
                  ];
                },
                body: body(),
              ),
            ),
          );
        },
      ),
    );

  }

  header() {
    cubit = BlocProvider.of(context);
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        UserModel userModel = UserModel();
        if (state is OnUserDataGet) {
          userModel = state.userModel;
        }

        if (cubit.userModel != null) {
          userModel = cubit.userModel!;
          return Container(
            color: AppColors.grey5,
            margin: EdgeInsets.only(top: 60),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    userModel.user.image.isNotEmpty
                        ? CachedNetworkImage(
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 96.0,
                                height: 96.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.colorPrimary, width: 1),
                                ),
                                child: CircleAvatar(
                                  radius: 96.0,
                                  backgroundImage: imageProvider,
                                ),
                              );
                            },
                            imageUrl: userModel.user.image,
                            width: 96.0,
                            height: 96.0,
                            placeholder: (context, url) {
                              return AppWidget.circleAvatarWithBorder(
                                  96.0, 96.0);
                            },
                            errorWidget: (context, url, error) {
                              return AppWidget.circleAvatarWithBorder(
                                  96.0, 96.0);
                            },
                          )
                        : AppWidget.circleAvatarWithBorder(96.0, 96.0),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      children: [
                        Text(
                          userModel.user.firstName +
                              " " +
                              userModel.user.lastName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  navigateToUserSignUpActivity();
                                },
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                    side: BorderSide(
                                        width: 1.0, color: AppColors.color1)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(
                                  'edit_profile'.tr(),
                                  style: TextStyle(
                                      fontSize: 14.0, color: AppColors.color1),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  cubit.deleteUserAccount();
                                },
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                    side: BorderSide(
                                        width: 1.0, color: AppColors.color1)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(
                                  'delete_profile'.tr(),
                                  style: TextStyle(
                                      fontSize: 14.0, color: AppColors.color1),
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Visibility(
                            visible: cubit.userModel!.user.userType
                                    .contains("client")
                                ? false
                                : true,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AppConstant.pageAddPostRoute)
                                    .then((value) => {cubit.getPosts()});
                              },
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: BorderSide(
                                      width: 1.0, color: AppColors.color1)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8.0),
                              child: Text(
                                'addPost'.tr(),
                                style: TextStyle(
                                    fontSize: 14.0, color: AppColors.color1),
                              ),
                            ))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidget.svg('calender.svg', AppColors.color1, 20.0, 20.0),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      userModel.user.birthdate,
                      style: TextStyle(fontSize: 16.0, color: AppColors.black),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    AppWidget.svg('pin.svg', AppColors.color1, 20.0, 20.0),
                    Expanded(
                        child: Text(
                      lang == 'ar'
                          ? userModel.user.city.cityNameAr
                          : userModel.user.city.cityNameEn,
                      style: TextStyle(fontSize: 16.0, color: AppColors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
                SizedBox(height: 7),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  body() {
    UserProfileCubit cubit = BlocProvider.of(context);

    return BlocListener<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is OnRemoveFavorite) {
          AppRoutes.mainPageCubit.getData();
        }
      },
      child: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          int index = cubit.index;
          if (state is UpdateIndex) {
            index = state.index;
          }
          return IndexedStack(
            index: index,
            children: _screens,
          );
        },
      ),
    );
  }

  // buildMyPostList() {
  //   UserProfileCubit cubit = BlocProvider.of(context);
  //
  //   return BlocBuilder<UserProfileCubit, UserProfileState>(
  //     builder: (context, state) {
  //       if(state is UpdateIndex){
  //         List<ProjectModel> list = cubit.my_posts;
  //
  //         if (list.length > 0) {
  //           return myPostWidget(list);
  //         } else {
  //           return Center(
  //             child: Text(
  //               'no_projects'.tr(),
  //
  //               style: TextStyle(color: AppColors.black, fontSize: 15.0),
  //             ),
  //           );
  //         }
  //
  //
  //       }
  //       else if (state is IsLoadingPosts||state is OnUserDataGet) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: AppColors.colorPrimary,
  //           ),
  //         );
  //       } else if (state is OnErrorPosts) {
  //         return Center(
  //           child: InkWell(
  //             onTap: refreshPosts,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 AppWidget.svg(
  //                     'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
  //                 SizedBox(
  //                   height: 8.0,
  //                 ),
  //                 Text(
  //                   'reload'.tr(),
  //                   style: TextStyle(
  //                       color: AppColors.colorPrimary, fontSize: 15.0),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         List<ProjectModel> list = cubit.my_posts;
  //
  //         if (list.length > 0) {
  //           return myPostWidget(list);
  //         } else {
  //           return Center(
  //             child: Text(
  //               'no_projects'.tr(),
  //
  //               style: TextStyle(color: AppColors.black, fontSize: 15.0),
  //             ),
  //           );
  //         }
  //       }
  //     },
  //   );
  // }
  //
  // myPostWidget(List<ProjectModel> list){
  //   String lang = EasyLocalization.of(context)!.locale.languageCode;
  //   return RefreshIndicator(
  //     color: AppColors.colorPrimary,
  //     onRefresh: refreshPosts,
  //     child: ListView.builder(
  //         itemCount: list.length,
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           ProjectModel model = list[index];
  //           String approved = "";
  //           if (model.approvedFrom.length > 0) {
  //             approved = model.approvedFrom
  //                 .map((e) => lang == 'ar'
  //                 ? "#" + e.title_ar
  //                 : "#" + e.title_en)
  //                 .join(' ');
  //           }
  //           return Container(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Card(
  //               color: AppColors.white,
  //               shape: const RoundedRectangleBorder(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(24.0))),
  //               elevation: 5.0,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 16.0, vertical: 8.0),
  //                 child: Column(
  //                   children: [
  //                     ListTile(
  //                       dense: true,
  //                       contentPadding: EdgeInsets.zero,
  //                       leading: CachedNetworkImage(
  //                           width: 60,
  //                           height: 60,
  //                           imageUrl: model.user.image,
  //                           placeholder: (context, url) =>
  //                               AppWidget.circleAvatar(60, 60),
  //                           errorWidget: (context, url, error) {
  //                             return Container(
  //                               color: AppColors.grey3,
  //                             );
  //                           },
  //                           imageBuilder: (context, imageProvider) =>
  //                               CircleAvatar(
  //                                 backgroundImage: imageProvider,
  //                                 radius: 60,
  //                               )),
  //                       title: Text(
  //                         model.user.firstName +
  //                             " " +
  //                             model.user.lastName,
  //                         style: TextStyle(
  //                             color: AppColors.black,
  //                             fontSize: 18.0,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       subtitle: Text(
  //                        // model.title,
  //                         style: TextStyle(
  //                           color: AppColors.grey1,
  //                           fontSize: 14.0,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     AspectRatio(
  //                       aspectRatio: 1 / .67,
  //                       child: ClipRRect(
  //                           borderRadius: const BorderRadius.all(
  //                               Radius.circular(8.0)),
  //                           child: model.image.isNotEmpty
  //                               ? CachedNetworkImage(
  //                             fit: BoxFit.cover,
  //                             imageUrl: model.image,
  //                           )
  //                               : Container(
  //                             color: AppColors.grey3,
  //                           )),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     Row(
  //                       mainAxisSize: MainAxisSize.max,
  //                       mainAxisAlignment:
  //                       MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           crossAxisAlignment:
  //                           CrossAxisAlignment.center,
  //                           children: [
  //                             InkWell(
  //                               onTap: () {
  //                                 addRemoveFavorite(index, model);
  //                               },
  //                               child: SizedBox(
  //                                 child: AppWidget.svg(
  //                                     'love.svg',
  //                                     AppColors.colorPrimary,
  //                                     24.0,
  //                                     24.0),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               width: 12,
  //                             ),
  //                             Text(
  //                               "${model.likesCount}",
  //                               style: TextStyle(
  //                                   fontSize: 14.0,
  //                                   color: AppColors.color1),
  //                             )
  //                           ],
  //                         ),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 8.0, horizontal: 12.0),
  //                           decoration: BoxDecoration(
  //                               color: AppColors.grey1,
  //                               borderRadius:
  //                               BorderRadius.circular(24.0)),
  //                           child: Row(
  //                             crossAxisAlignment:
  //                             CrossAxisAlignment.center,
  //                             children: [
  //                               SizedBox(
  //                                 width: 24.0,
  //                                 height: 24.0,
  //                                 child: AppWidget.svg('donate.svg',
  //                                     AppColors.white, 24.0, 24.0),
  //                               ),
  //                               Text(
  //                                 'donate'.tr(),
  //                                 style: const TextStyle(
  //                                     fontSize: 12.0,
  //                                     color: AppColors.white),
  //                               )
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: RichText(
  //                         maxLines: 3,
  //                         overflow: TextOverflow.ellipsis,
  //                         text: TextSpan(
  //                             text: model.text,
  //                             style: const TextStyle(
  //                               fontSize: 14.0,
  //                               color: AppColors.black,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             children: []),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     approved.isNotEmpty
  //                         ? Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Text(
  //                           approved,
  //                           maxLines: 3,
  //                           softWrap: true,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                               color: AppColors.colorPrimary,
  //                               fontSize: 16.0),
  //                         ))
  //                         : SizedBox(),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  buildMyFavoriteList() {
    UserProfileCubit cubit = BlocProvider.of(context);

    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        if (state is UpdateIndex) {
          if (cubit.posts.length > 0) {
            return myFavoriteWidget(cubit.posts);
          } else {
            return Center(
              child: Text(
                'no_posts'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        } else if (state is IsLoadingData || state is OnUserDataGet) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.colorPrimary,
            ),
          );
        } else if (state is OnError) {
          return Center(
            child: InkWell(
              onTap: refreshData,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppWidget.svg(
                      'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'reload'.tr(),
                    style: TextStyle(
                        color: AppColors.colorPrimary, fontSize: 15.0),
                  )
                ],
              ),
            ),
          );
        } else {
          List<ProjectModel> list = cubit.posts;

          if (list.length > 0) {
            return myFavoriteWidget(list);
          } else {
            return Center(
              child: Text(
                'no_projects'.tr(),
                style: TextStyle(color: AppColors.black, fontSize: 15.0),
              ),
            );
          }
        }
      },
    );
  }

  myFavoriteWidget(List<ProjectModel> list) {
    String lang = EasyLocalization.of(context)!.locale.languageCode;

    return RefreshIndicator(
      color: AppColors.colorPrimary,
      onRefresh: refreshData,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ProjectModel model = list[index];
            // String approved = "";
            // if (model.approvedFrom.length > 0) {
            //   approved = model.approvedFrom
            //       .map((e) => lang == 'ar'
            //       ? "#" + e.title_ar
            //       : "#" + e.title_en)
            //       .join(' ');
            // }
            return Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: AppColors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0))),
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: CachedNetworkImage(
                            width: 60,
                            height: 60,
                            imageUrl: model.provider.user.image,
                            placeholder: (context, url) =>
                                AppWidget.circleAvatar(60, 60),
                            errorWidget: (context, url, error) {
                              return Container(
                                color: AppColors.grey3,
                              );
                            },
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                                  backgroundImage: imageProvider,
                                  radius: 60,
                                )),
                        title: Text(
                          model.provider.user.firstName +
                              " " +
                              model.provider.user.lastName,
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          lang.contains("ar")
                              ? model.provider.main_category.title_ar
                              : model.provider.main_category.title_en,
                          style: TextStyle(
                            color: AppColors.grey1,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      AspectRatio(
                        aspectRatio: 1 / .67,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0)),
                            child: model.img.isNotEmpty
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: model.img,
                                  )
                                : Container(
                                    color: AppColors.grey3,
                                  )),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: cubit.userModel!.user.userType
                                          .contains("client")
                                      ? true
                                      : false,
                                  child: InkWell(
                                    onTap: () {
                                      addRemoveFavorite(index, model);
                                    },
                                    child: SizedBox(
                                      child: AppWidget.svg(
                                          'love.svg',
                                          model.action_user.contains("unlove")
                                              ? AppColors.grey1
                                              : AppColors.colorPrimary,
                                          24.0,
                                          24.0),
                                    ),
                                  )),
                              const SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: model.description,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: AppColors.black,
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: []),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // buildSavedPostList() {
  //   UserProfileCubit cubit = BlocProvider.of(context);
  //
  //   return BlocBuilder<UserProfileCubit, UserProfileState>(
  //     builder: (context, state) {
  //       if(state is UpdateIndex){
  //         if (cubit.savedPosts.length > 0) {
  //           return savedPostWidget(cubit.savedPosts);
  //         } else {
  //           return Center(
  //             child: Text(
  //               'no_projects'.tr(),
  //
  //               style: TextStyle(color: AppColors.black, fontSize: 15.0),
  //             ),
  //           );
  //         }
  //
  //       }
  //       else if (state is IsLoadingData||state is OnUserDataGet) {
  //         return Center(
  //           child: CircularProgressIndicator(
  //             color: AppColors.colorPrimary,
  //           ),
  //         );
  //       } else if (state is OnError) {
  //         return Center(
  //           child: InkWell(
  //             onTap: refreshSavedPosts,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 AppWidget.svg(
  //                     'reload.svg', AppColors.colorPrimary, 24.0, 24.0),
  //                 SizedBox(
  //                   height: 8.0,
  //                 ),
  //                 Text(
  //                   'reload'.tr(),
  //                   style: TextStyle(
  //                       color: AppColors.colorPrimary, fontSize: 15.0),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       } else {
  //         List<ProjectModel> list = cubit.savedPosts;
  //
  //         if (list.length > 0) {
  //           return savedPostWidget(list);
  //         } else {
  //           return Center(
  //             child: Text(
  //               'no_projects'.tr(),
  //
  //               style: TextStyle(color: AppColors.black, fontSize: 15.0),
  //             ),
  //           );
  //         }
  //       }
  //     },
  //   );
  // }
  // savedPostWidget(List<ProjectModel> list){
  //   String lang = EasyLocalization.of(context)!.locale.languageCode;
  //
  //   return RefreshIndicator(
  //     color: AppColors.colorPrimary,
  //     onRefresh: refreshSavedPosts,
  //     child: ListView.builder(
  //         itemCount: list.length,
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           ProjectModel model = list[index];
  //           String approved = "";
  //           if (model.approvedFrom.length > 0) {
  //             approved = model.approvedFrom
  //                 .map((e) => lang == 'ar'
  //                 ? "#" + e.title_ar
  //                 : "#" + e.title_en)
  //                 .join(' ');
  //           }
  //           return Container(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Card(
  //               color: AppColors.white,
  //               shape: const RoundedRectangleBorder(
  //                   borderRadius:
  //                   BorderRadius.all(Radius.circular(24.0))),
  //               elevation: 5.0,
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 16.0, vertical: 8.0),
  //                 child: Column(
  //                   children: [
  //                     ListTile(
  //                       dense: true,
  //                       contentPadding: EdgeInsets.zero,
  //                       leading: CachedNetworkImage(
  //                           width: 60,
  //                           height: 60,
  //                           imageUrl: model.user.image,
  //                           placeholder: (context, url) =>
  //                               AppWidget.circleAvatar(60, 60),
  //                           errorWidget: (context, url, error) {
  //                             return Container(
  //                               color: AppColors.grey3,
  //                             );
  //                           },
  //                           imageBuilder: (context, imageProvider) =>
  //                               CircleAvatar(
  //                                 backgroundImage: imageProvider,
  //                                 radius: 60,
  //                               )),
  //                       title: Text(
  //                         model.user.firstName +
  //                             " " +
  //                             model.user.lastName,
  //                         style: TextStyle(
  //                             color: AppColors.black,
  //                             fontSize: 18.0,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       subtitle: Text(
  //                         model.title,
  //                         style: TextStyle(
  //                           color: AppColors.grey1,
  //                           fontSize: 14.0,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     AspectRatio(
  //                       aspectRatio: 1 / .67,
  //                       child: ClipRRect(
  //                           borderRadius: const BorderRadius.all(
  //                               Radius.circular(8.0)),
  //                           child: model.image.isNotEmpty
  //                               ? CachedNetworkImage(
  //                             fit: BoxFit.cover,
  //                             imageUrl: model.image,
  //                           )
  //                               : Container(
  //                             color: AppColors.grey3,
  //                           )),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     Row(
  //                       mainAxisSize: MainAxisSize.max,
  //                       mainAxisAlignment:
  //                       MainAxisAlignment.spaceBetween,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           crossAxisAlignment:
  //                           CrossAxisAlignment.center,
  //                           children: [
  //                             InkWell(
  //                               onTap: () {
  //                                 addRemoveFavorite(index, model);
  //                               },
  //                               child: SizedBox(
  //                                 child: AppWidget.svg(
  //                                     'love.svg',
  //                                     AppColors.colorPrimary,
  //                                     24.0,
  //                                     24.0),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               width: 12,
  //                             ),
  //                             Text(
  //                               "${model.likesCount}",
  //                               style: TextStyle(
  //                                   fontSize: 14.0,
  //                                   color: AppColors.color1),
  //                             )
  //                           ],
  //                         ),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                               vertical: 8.0, horizontal: 12.0),
  //                           decoration: BoxDecoration(
  //                               color: AppColors.grey1,
  //                               borderRadius:
  //                               BorderRadius.circular(24.0)),
  //                           child: Row(
  //                             crossAxisAlignment:
  //                             CrossAxisAlignment.center,
  //                             children: [
  //                               SizedBox(
  //                                 width: 24.0,
  //                                 height: 24.0,
  //                                 child: AppWidget.svg('donate.svg',
  //                                     AppColors.white, 24.0, 24.0),
  //                               ),
  //                               Text(
  //                                 'donate'.tr(),
  //                                 style: const TextStyle(
  //                                     fontSize: 12.0,
  //                                     color: AppColors.white),
  //                               )
  //                             ],
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     Align(
  //                       alignment: Alignment.centerLeft,
  //                       child: RichText(
  //                         maxLines: 3,
  //                         overflow: TextOverflow.ellipsis,
  //                         text: TextSpan(
  //                             text: model.text,
  //                             style: const TextStyle(
  //                               fontSize: 14.0,
  //                               color: AppColors.black,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             children: []),
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                     approved.isNotEmpty
  //                         ? Align(
  //                         alignment: Alignment.centerLeft,
  //                         child: Text(
  //                           approved,
  //                           maxLines: 3,
  //                           softWrap: true,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                               color: AppColors.colorPrimary,
  //                               fontSize: 16.0),
  //                         ))
  //                         : SizedBox(),
  //                     const SizedBox(
  //                       height: 8.0,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }

  Future<void> refreshData() async {
    UserProfileCubit cubit = BlocProvider.of<UserProfileCubit>(context);
    cubit.getFavoritePosts();
  }

  Future<void> refreshPosts() async {
    UserProfileCubit cubit = BlocProvider.of<UserProfileCubit>(context);
    cubit.getPosts();
  }

  void addRemoveFavorite(int index, ProjectModel model) {
    UserProfileCubit cubit = BlocProvider.of<UserProfileCubit>(context);
    String type;
    if (model.action_user.contains("unlove")) {
      type = AppConstant.actionLove;
    } else {
      type = AppConstant.actionunLove;
    }
    cubit.love_report_follow(index, model, type);
  }

  Widget buildTab(String title, String icon, int index) {
    UserProfileCubit cubit = BlocProvider.of(context);
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        int selectedIndex = cubit.index;
        if (state is UpdateIndex) {
          selectedIndex = state.index;
        }
        return Tab(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.colorPrimary
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppWidget.svg(
                    icon,
                    selectedIndex == index ? AppColors.white : AppColors.color1,
                    24.0,
                    24.0),
                SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: selectedIndex == index
                          ? AppColors.white
                          : AppColors.color1,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void navigateToUserSignUpActivity() async {
    UserModel model = await Preferences.instance.getUserModel();
    LoginModel loginModel = LoginModel();
    loginModel.phone_code = model.user.phoneCode;
    loginModel.phone = model.user.phone;

    var result;
    if (model.user.userType == "client") {
      result = await Navigator.of(context).pushNamed(
          AppConstant.pageUserSignUpRoleRoute,
          arguments: loginModel);
    } else {
      result = await Navigator.of(context).pushNamed(
          AppConstant.pageInvestorSignUpRoleRoute,
          arguments: loginModel);
    }
    if (result != null) {
      UserProfileCubit cubit = BlocProvider.of<UserProfileCubit>(context);
      cubit.getUserData();
    }
  }
}
