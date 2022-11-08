import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/category_model.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/consultant_type_model.dart';
import 'package:ezdihar_apps/models/send_general_study_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_model.dart';
import 'package:ezdihar_apps/preferences/preferences.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../models/add_post_model.dart';


part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  XFile? imageFile;
  String imageType = '';
  bool isDataValid = false;

  AddPostModel model = AddPostModel();
  late ServiceApi api;

  AddPostCubit() : super(AddPostInitial()) {

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
    model.project_photo_path = croppedFile!.path;

    emit(PhotoPicked(model.project_photo_path));
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




  // updateConsultantTypeData(ConsultantTypeModel model,int pos){
  //   list[pos] = model;
  //   this.model.addRemoveConsultant(model);
  //   emit(OnConsultantTypesSuccess(list));
  //   checkData();
  //
  // }

  addPost() async {
    try {
      emit(IsLoading());
      UserModel model = await Preferences.instance.getUserModel();
      if (model.user.isLoggedIn) {
        StatusResponse response =
            await api.addProviderPost(model.access_token, this.model);
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
