import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'consultant_details_state.dart';

class ConsultantDetailsCubit extends Cubit<ConsultantDetailsState> {
  late ServiceApi api;
  UserModel? userModel;

  ConsultantDetailsCubit() : super(IsLoading()) {
    api = ServiceApi();
  }

  void getData(int consultant_id) async {
    emit(IsLoading());
    try {
      UserDataModel userDataModel =
          await api.getConsultantDetails(consultant_id);
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
