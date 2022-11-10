import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/colors/colors.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  int index = 0;
  late ServiceApi api;
  UserModel? userModel;
  late List<ProjectModel> posts;

  UserProfileCubit() : super(UpdateIndex(0)) {
    posts =[];
    api = ServiceApi();
    getUserData().then((value) {
      emit(OnUserDataGet(value!));
    });
  //  getPosts();
    Future.delayed(Duration(seconds: 1)).then((value){
      if(userModel!.user.userType.contains("client")){
      getFavoritePosts();}
      else{
        getPosts();
      }
    });
    // Future.delayed(Duration(seconds: 1)).then((value){
    //   getSaved();    });

  }


  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getFavoritePosts() async{
    try{
      emit(IsLoadingData());
      ProjectsDataModel response =  await api.getMyFavorites(userModel!.access_token);

      if(response.status.code==200){
        posts = response.data;
        emit(OnFavDataSuccess(posts));
      }
    }catch (e){
      emit(OnError(e.toString()));
    }

  }


  getPosts() async{

    try{
      emit(IsLoadingPosts());
      ProjectsDataModel response =  await api.getMyPosts(userModel!.access_token);

      if(response.status.code==200){
        posts = response.data;
        emit(OnFavDataSuccess(posts));
      }
    }catch (e){
      emit(OnErrorPosts(e.toString()));
    }


  }
  // getSaved() async{
  //   try{
  //     getUserData().then((value) async{
  //       emit(IsLoadingData());
  //       ProjectsDataModel response =  await api.getSaved(value!.access_token);
  //
  //       if(response.status.code==200){
  //         savedPosts = response.data;
  //         emit(OnSavedPostsSuccess(savedPosts));
  //       }
  //     });
  //   }catch (e){
  //     emit(OnError(e.toString()));
  //   }
  //
  // }
  void onErrorData(String error) {
    emit(OnError(error));
  }

  void onErrorPosts(String error) {
    emit(OnError(error));
  }
  deleteProject(ProjectModel model,int index) async{
    posts.removeAt(index);
    emit(OnMyPostsSuccess(posts));
    try{
      StatusResponse response = await api.deleteProject(userModel!.access_token, model.id);
      if(response.code==200){
        Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);

      }else{
        posts[index] = model;
        emit(OnMyPostsSuccess(posts));
      }
    }catch (e){

      Future.delayed(Duration(seconds: 1)).then((value) => emit(OnError(e.toString())));
    }
  }
  void love_report_follow(int post_index,ProjectModel model,String type) async{
    try{
      getUserData().then((value) async{
        StatusResponse response =  await api.love_follow_report(value!.access_token, model.id, type);
        if(response.code==200){
          posts.removeAt(post_index);
          emit(OnFavDataSuccess(posts));

          Future.delayed(Duration(seconds: 1))
              .then((value) =>emit(OnRemoveFavorite()));

        }else{

        }
      });

    }catch (e){
      emit(OnError(e.toString()));
    }
  }


}
