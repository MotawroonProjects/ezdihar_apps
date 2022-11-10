import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../models/add_report_model.dart';

part 'add_report_state.dart';

class AddReportCubit extends Cubit<AddReportState> {
  XFile? imageFile;
  String imageType = '';
  bool isDataValid = false;

  AddReportModel model = AddReportModel();
  late ServiceApi api;

  AddReportCubit() : super(AddReportInitial()) {
    api = ServiceApi();
    //  getData(model.category_id);
  }

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';

    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 90);
    model.photo = croppedFile!.path;

    emit(PhotoPicked(model.photo));
    checkData();
  }

  void checkData() {
    if (model.isDataValid()) {
      isDataValid = true;
    } else {
      isDataValid = false;
    }

    emit(OnDataValid(isDataValid));
  }

  addReport() async {
    try {
      emit(IsLoading());
      UserModel model = await Preferences.instance.getUserModel();
      if (model.user.isLoggedIn) {
        StatusResponse response;
        if (model.user.userType.contains("freelancer")) {
          response = await api.addReport(model.access_token, this.model);
        } else {
          response =
              await api.addReportProvider(model.access_token, this.model);
        }
        if (response.code == 200) {
          emit(OnAddedSuccess());
        } else {
          OnDataError("Error data");
        }
      }
    } catch (e) {
      print("err=> ${e.toString()}");
      OnDataError(e.toString());
    }
  }
}
