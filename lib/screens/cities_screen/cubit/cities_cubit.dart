import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/city_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'cities_state.dart';

class CitiesCubit extends Cubit<CitiesState> {
  late ServiceApi api;
  late List<CityModel> list;
  late List<CityModel> data;
  late bool isSearch;

  CitiesCubit() : super(IsLoading()) {
    api = ServiceApi();
    list = [];
    data = [];
    isSearch = false;
    getCities();
  }

  void getCities() async {
    try{
      emit(IsLoading());
      CityDataModel response = await api.getCities();
      if(response.status.code==200){
        list = response.data;
        emit(OnDataSuccess(list));
      }
    }catch (e){
      OnError(e.toString());
    }
  }

  void search(String query){
    data = [];
    print("query${query}");
    if(query.isEmpty){
      isSearch = false;
      emit(OnDataSuccess(list));
    }else{
      isSearch = true;
      for(CityModel model in list){
        if(model.cityNameAr.toLowerCase().contains(query)||model.cityNameEn.toLowerCase().contains(query)){
          data.add(model);
          print("data=>${data.length}");
        }
      }

      emit(OnDataSuccess(data));

    }

  }
}
