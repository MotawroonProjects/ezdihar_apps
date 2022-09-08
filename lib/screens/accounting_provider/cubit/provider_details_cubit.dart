import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'provider_details_state.dart';

class ProviderDetailsCubit extends Cubit<ProviderDetailsState> {
  late ServiceApi api;
  UserModel? userModel;

  ProviderDetailsCubit() : super(IsLoading()) {
    api = ServiceApi();
  }

  void getData(int consultant_id,int cate_id) async {
    emit(IsLoading());
    try {
      UserDataModel userDataModel =
          await api.getproviderDetails(consultant_id,cate_id);
      if(userDataModel.status.code==200){
        userModel = userDataModel.userModel;

      }
      emit(OnDataSuccess(userModel!));
    } catch (e) {
      print("Erroror${e.toString()}");
      emit(OnError(e.toString()));
    }
  }
}
