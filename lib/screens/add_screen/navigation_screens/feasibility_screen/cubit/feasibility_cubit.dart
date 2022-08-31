import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:meta/meta.dart';

part 'feasibility_state.dart';

class FeasibilityCubit extends Cubit<FeasibilityState> {
  late List<CategoryModel> categories;
  late ServiceApi api;
  FeasibilityCubit() : super(IsCategoryLoading()){
    categories = [];
    api = ServiceApi();
    getCategories();
  }

  void getCategories() async {
    try {
      categories =[];
      emit(IsCategoryLoading());
      CategoryDataModel categoryDataModel = await api.getCategory();
      if(categoryDataModel.status.code==200){
        categories.addAll(categoryDataModel.data);
        emit(OnCategoryDataSuccess(categories));

      }else{

      }


    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
