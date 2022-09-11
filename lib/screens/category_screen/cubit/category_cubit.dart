import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  late ServiceApi api;
  late List<CategoryModel> list;

  CategoryCubit() : super(IsLoading()) {
    api = ServiceApi();
    list = [];

    getCategory();
  }

  void getCategory() async {
    try{
      emit(IsLoading());
      CategoryDataModel response = await api.getCategory();
      if(response.status.code==200){
        list = response.data;
        emit(OnDataSuccess(list));
      }
    }catch (e){
      OnError(e.toString());
    }
  }


}
