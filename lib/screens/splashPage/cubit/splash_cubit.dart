import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';
import '../../../preferences/preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
    onUserDataSuccess();
  }

  onUserDataSuccess() async {
    UserModel model = await Preferences.instance.getUserModel();
    if(model.user.isLoggedIn){
      emit(OnUserModelGet(model));
    }else{
      emit(NoUserFound());
    }
  }
}
