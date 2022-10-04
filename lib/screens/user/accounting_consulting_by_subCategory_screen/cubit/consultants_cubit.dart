import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/consultants_data_model.dart';
import 'package:ezdihar_apps/models/provider_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'consultants_state.dart';

class ConsultantsCubit extends Cubit<ConsultantsState> {
  late List<UserModel> data;
  late ServiceApi api;
  ConsultantsCubit() : super(IsLoading()){
    data = [];
    api= ServiceApi();

  }

  void getData(int consultant_type_id) async{
    try{
      emit(IsLoading());

      ProviderDataModel response = await api.getConsultantsBySubCategories(consultant_type_id);
      print("Error${response.status.code}");

      if(response.status.code==200){
        data = response.data;
        emit(OnDataSuccess(data));
      }
    }catch(e){
      print("Error${e.toString()}");
      emit(OnError(e.toString()));
    }
  }
}
