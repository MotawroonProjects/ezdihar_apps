import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/send_general_study_model.dart';
import 'package:meta/meta.dart';

part 'send_general_study_state.dart';

class SendGeneralStudyCubit extends Cubit<SendGeneralStudyState> {
  SendGeneralStudyModel model = SendGeneralStudyModel();

  SendGeneralStudyCubit() : super(SendGeneralStudyInitial());

  void checkData() {
    if (model.isDataValid()) {
      emit(OnDataValid());
    } else {
      emit(SendGeneralStudyInitial());
    }
  }

  void updateShowProjectInvestment(bool value) {
    model.showProjectInvestment = value;
    emit(OnShowProjectInvestmentChanged(model.showProjectInvestment));
  }
}
