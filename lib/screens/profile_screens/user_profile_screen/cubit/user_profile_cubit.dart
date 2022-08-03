import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  int index = 0;
  late ServiceApi api;
  UserModel? userModel;
  late List<ProjectModel> projects;
  late List<ProjectModel> posts;

  UserProfileCubit() : super(UpdateIndex(0)) {
    projects =[];
    posts = [];
    api = ServiceApi();
    getUserData().then((value) {
      emit(OnUserDataGet(value!));
    });
    getPosts();
    getData();

  }

  updateIndex(int index) {
    this.index = index;
    emit(UpdateIndex(index));
    if(index==0){
      emit(OnDataSuccess(projects));

    }else{
      emit(OnPostsSuccess(posts));

    }
  }

  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getData() async{
    try{
      getUserData().then((value) async{
        emit(IsLoadingData());
        ProjectsDataModel response =  await api.getMyFavorites(value!.access_token);

        if(response.status.code==200){
          projects = response.data;
          emit(OnDataSuccess(projects));
        }
      });
    }catch (e){
      emit(OnError(e.toString()));
    }

  }

  getPosts() async{

    try{
      getUserData().then((value) async{
        emit(IsLoadingData());
        ProjectsDataModel response =  await api.getMyPosts(value!.access_token);

        if(response.status.code==200){
          projects = response.data;
          emit(OnDataSuccess(projects));
        }
      });
    }catch (e){
      emit(OnErrorPosts(e.toString()));
    }


  }

  void onErrorData(String error) {
    emit(OnError(error));
  }

  void onErrorPosts(String error) {
    emit(OnError(error));
  }

  void love_report_follow(int post_index,ProjectModel model,String type) async{
    try{
      getUserData().then((value) async{
        StatusResponse response =  await api.love_follow_report(value!.access_token, model.id, type);
        if(response.code==200){
          projects.removeAt(post_index);

          emit(OnDataSuccess(projects));

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
