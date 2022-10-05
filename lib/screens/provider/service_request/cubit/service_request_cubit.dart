import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'service_request_state.dart';

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  ServiceRequestCubit() : super(ServiceRequestInitial());
  DateTime initialDate = DateTime(DateTime.now().year - 10);
  DateTime startData = DateTime(DateTime.now().year - 100);
  DateTime endData = DateTime(DateTime.now().year - 10);
  String birthDate = 'YYYY-MM-DD';
  bool isDataValid = false;

  updateBirthDate({required String date}) {
    this.birthDate = date;
    emit(UserBirthDateSelected(date));
    checkData();
  }

  checkData() {
    // if (model.isDataValid()) {
    //   isDataValid = true;
    // } else {
    //   isDataValid = false;
    // }

    emit(UserDataValidation(isDataValid));
  }
}
