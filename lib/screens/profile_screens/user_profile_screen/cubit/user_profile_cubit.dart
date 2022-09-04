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
  late List<ProjectModel> fav_posts;
  late List<ProjectModel> my_posts;
  late List<ProjectModel> savedPosts;
  UserProfileCubit() : super(UpdateIndex(0)) {
    fav_posts =[];
    my_posts = [];
    savedPosts=[];
    api = ServiceApi();
    getUserData().then((value) {
      emit(OnUserDataGet(value!));
    });
    getPosts();
    Future.delayed(Duration(seconds: 1)).then((value){
      getFavoritePosts();
    });
    Future.delayed(Duration(seconds: 1)).then((value){
      getSaved();    });

  }

  updateIndex(int index) {
    this.index = index;
    emit(UpdateIndex(index));
    if(index==0){
      emit(OnFavDataSuccess(fav_posts));

    }else if(index==1){
      emit(OnMyPostsSuccess(my_posts));

    }
    else{
      emit(OnSavedPostsSuccess(savedPosts));

    }
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
        fav_posts = response.data;
        emit(OnFavDataSuccess(fav_posts));
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
        my_posts = response.data;
        emit(OnMyPostsSuccess(my_posts));
      }
    }catch (e){
      emit(OnErrorPosts(e.toString()));
    }


  }
  getSaved() async{
    try{
      getUserData().then((value) async{
        emit(IsLoadingData());
        ProjectsDataModel response =  await api.getSaved(value!.access_token);

        if(response.status.code==200){
          savedPosts = response.data;
          emit(OnSavedPostsSuccess(savedPosts));
        }
      });
    }catch (e){
      emit(OnError(e.toString()));
    }

  }
  void onErrorData(String error) {
    emit(OnError(error));
  }

  void onErrorPosts(String error) {
    emit(OnError(error));
  }
  deleteProject(ProjectModel model,int index) async{
    my_posts.removeAt(index);
    emit(OnMyPostsSuccess(my_posts));
    try{
      StatusResponse response = await api.deleteProject(userModel!.access_token, model.id);
      if(response.code==200){
        Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);

      }else{
        my_posts[index] = model;
        emit(OnMyPostsSuccess(my_posts));
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
          fav_posts.removeAt(post_index);
          emit(OnFavDataSuccess(fav_posts));

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
