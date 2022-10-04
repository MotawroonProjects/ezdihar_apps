import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'sub_services_state.dart';

class SubServicesCubit extends Cubit<SubServicesState> {
  late ServiceApi api;
  late List<CategoryModel> list;

  SubServicesCubit() : super(Isloading()){
    api =ServiceApi();

    list =[];

  }
  getData(int category_id) async {

    try{
      emit(Isloading());
      CategoryDataModel response = await api.getSubCategories(category_id);
     log(response.status.code);
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
   emit(OnEror(error));

  }
}
