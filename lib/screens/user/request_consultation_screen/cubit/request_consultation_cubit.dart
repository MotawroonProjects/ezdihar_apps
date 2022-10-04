import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/request_consultant_model.dart';
import 'package:meta/meta.dart';

part 'request_consultant_state.dart';

class RequestConsultationCubit extends Cubit<RequestConsultantState> {
  RequestConsultationModel model = RequestConsultationModel();
  RequestConsultationCubit() : super(RequestConsultantInitial());
  void checkData(){
    if(model.isDataValid()){
      emit(OnDataValid());
    }else{
      emit(RequestConsultantInitial());
    }
  }
}
