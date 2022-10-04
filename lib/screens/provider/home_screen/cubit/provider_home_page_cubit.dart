import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/provider_home_page_model.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../remote/service.dart';

part 'provider_home_page_state.dart';

class ProviderHomePageCubit extends Cubit<ProviderHomePageState> {
  ProviderHomePageCubit() : super(ProviderHomePageInitial()){
    api = ServiceApi();
    onUserDataSuccess();
  }
  late ServiceApi api;
   UserModel? user;
  onUserDataSuccess() async {
    user = await Preferences.instance.getUserModel();
    emit(UserDataDone());
  }

  getHomePageData() async {
    emit(ProviderHomePageLoading());
    var model =await api.getProviderHomePageData(user!.access_token);
    emit(ProviderHomePageLoaded(model));
  }
}
