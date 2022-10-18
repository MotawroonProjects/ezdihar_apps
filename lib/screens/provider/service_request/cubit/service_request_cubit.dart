import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/chat_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../models/send_service_request_model.dart';
import '../../../../models/user_model.dart';
import '../../../../preferences/preferences.dart';
import '../../../../remote/service.dart';
import '../../../../widgets/app_widgets.dart';

part 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  DateTime initialDate = DateTime(DateTime.now().year - 10);
  DateTime startData = DateTime(DateTime.now().year - 100);
  DateTime endData = DateTime(DateTime.now().year - 10);
  String birthDate = 'YYYY-MM-DD';
  bool isDataValid = false;
  SendServiceRequestModel serviceRequestModel = SendServiceRequestModel();
  late ServiceApi api;
  ServiceRequestCubit() : super(ServiceRequestInitial()) {
    api = ServiceApi();

  }

  updateBirthDate({required String date}) {
    this.birthDate = date;
    serviceRequestModel.dateOfBirth = date;
    emit(UserBirthDateSelected(date));
    checkData();
  }

  checkData() {
    if (serviceRequestModel.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }

    emit(UserDataValidation(isDataValid));
  }
  void sendOrder(BuildContext context,ChatModel chatModel) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    UserModel model = await Preferences.instance.getUserModel();
    String user_token = '';
    if (model.user.isLoggedIn) {
      user_token = model.access_token;
    }
    serviceRequestModel.category_id=chatModel.sub_category_id;
    serviceRequestModel.user_id=chatModel.user_id;
    serviceRequestModel.room_id=chatModel.id;

    try {
      StatusResponse response = await api.sendServiceRequest(user_token,serviceRequestModel);
      Navigator.pop(context);

      if (response.code == 200) {
        emit(OnOrderSuccess(response));
      }
      // } else {
      //   if(response.status.code==407){
      //     Fluttertoast.showToast(
      //         msg: "wallet_not_enough".tr(),  // message
      //         toastLength: Toast.LENGTH_SHORT, // length
      //         gravity: ToastGravity.BOTTOM,    // location
      //         timeInSecForIosWeb: 1               // duration
      //     );
      //   }
      //   print("errorCode=>${response.status.code}");
      // }
    } catch (e) {
      print("error${e.toString()}");
      Navigator.pop(context);
      emit(OnError(e.toString()));
    }
  }

}
