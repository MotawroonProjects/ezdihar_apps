import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/consultant_sign_up_model.dart';
import 'package:ezdihar_apps/screens/auth_screens/login_screen/cubit/login_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'consultant_state.dart';

class ConsultantSignUpCubit extends Cubit<ConsultantState> {
  String fileName = '';

  ConsultantSignUpModel model = ConsultantSignUpModel();
  bool isDataValid = false;

  ConsultantSignUpCubit() : super(ConsultantInitial());

  pickUpFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      String name = result.files.first.name;
      if (name.toLowerCase().endsWith('.pdf')) {
        fileName = name;
        model.cv_path = result.files.first.path!;
        print("fileName=>${name}");
      } else {
        fileName = '';
      }
      emit(ConsultantFilePicked(fileName));
      checkData();
    }
  }

  updateYears(String years) {
    model.years_experience = years;
    emit(ConsultantYearsChanged(years));
  }

  increaseYears() {
    int years = int.parse(model.years_experience);
    years++;
    model.years_experience = years.toString();
    updateYears(model.years_experience);
  }

  decreaseYears() {
    int years = int.parse(model.years_experience);

    if (years > 0) {
      years--;
      updateYears(years.toString());
    }
  }


  checkData() {
    if (model.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }
    emit(ConsultantDataValidation(isDataValid));
  }
}
