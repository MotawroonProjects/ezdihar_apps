import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:meta/meta.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  late UserModel userModel;
  MoreCubit() : super(MoreInitial()){
    getUserModel();
  }

  void getUserModel() async{
    userModel = await Preferences.instance.getUserModel();

    emit(OnUserModelGet(userModel));
  }

  void onUserDataUpdated(UserModel userModel){
    emit(OnUserModelGet(userModel));

  }


}
