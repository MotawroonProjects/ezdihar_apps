import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/project_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  late ServiceApi api;
  UserModel? userModel;
  late List<ProjectModel> projects;
  FavoriteCubit() : super(IsLoadingData()){
    projects =[];
    api = ServiceApi();
    getUserData();
    getData();
  }


  Future<UserModel?> getUserData() async {
    userModel = await Preferences.instance.getUserModel();
    return userModel;
  }

  getData() async{
    getUserData().then((value) async{
      emit(IsLoadingData());
      ProjectsDataModel response =  await api.getMyFavorites(value!.access_token);

      if(response.status.code==200){
        projects = response.data;
        emit(OnDataSuccess(projects));
      }
    });
  }

  void onErrorData(String error) {
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
