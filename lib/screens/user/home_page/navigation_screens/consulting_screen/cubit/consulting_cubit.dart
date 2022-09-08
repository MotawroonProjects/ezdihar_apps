import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'consulting_state.dart';

class ConsultingCubit extends Cubit<ConsultingState> {
  late List<ConsultantTypeModel> list;
  late ServiceApi api;

  ConsultingCubit() : super(IsLoading()) {
    list = [];
    api = ServiceApi();
    getData();
  }

  getData() async {
    try{
      emit(IsLoading());
      ConsultantDataModel response = await api.getConsultantTypes();
      if(response.status.code==200){
        list = response.list;
        emit(OnDataSuccess(list));
      }
    }catch (e){
      print('RRRrrr${e.toString()}');
      onErrorData(e.toString());
    }

  }

  void onErrorData(String error){
    emit(OnError(error));
  }
}
