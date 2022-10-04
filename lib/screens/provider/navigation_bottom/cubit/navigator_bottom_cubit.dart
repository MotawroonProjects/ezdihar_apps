import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';

part 'navigator_bottom_state.dart';

class NavigatorBottomCubit extends Cubit<NavigatorBottomState> {
  NavigatorBottomCubit() : super(NavigatorBottomInitial()){
    onUserDataSuccess();
  }
  int page = 0;
  UserModel? user;
  String lan ='ff';
  getLan(context) {
    lan = EasyLocalization.of(context)!.locale.languageCode;
  }

  onUserDataSuccess() async {
    user = await Preferences.instance.getUserModel().whenComplete(() => null);
  }

  changePage(int index) {
    page = index;
    emit(NavigatorBottomChangePage());
  }
}
