import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  late ServiceApi api;
  late List<CategoryModel> list;

  ServicesCubit() : super(IsLoading()){
    list =[];
    api =ServiceApi();
    getData();
  }
  getData() async {

    try{
      emit(IsLoading());
      CategoryDataModel response = await api.getCategory();
      if(response.status.code==200){
        list = response.data;
        emit(OnDataSuccess(list));
      }
    }catch (e){
      onErrorData(e.toString());
      print("RRRr${e.toString()}");
    }

  }
  void onErrorData(String error){
   emit(OnError(error));

  }
}
