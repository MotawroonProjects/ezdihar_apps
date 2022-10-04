import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/models/contact_us_model.dart';
import 'package:ezdihar_apps/remote/service.dart';
import 'package:flutter/material.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactModel model = ContactModel();
  String emailValidMessage="contactUsEmailValidator".tr();
  late ServiceApi api;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  ContactUsCubit() : super(ContactUsInitial()) {
    api = ServiceApi();
  }

   validMessage(String message) {
    if(message=="@"){
      emailValidMessage ="notEmail".tr();
      emit(CorrectEmail());
    }else{

      emailValidMessage ="contactUsEmailValidator".tr();
      emit(CorrectEmail());
    }
  }

  send() {
    emit(ContactUsLoading());
    api.contactUsData(
      ContactModel(
        name: nameController.text,
        email: emailController.text,
        subject: subjectController.text,
        message: messageController.text,
      ),
    );
    emit(ContactUsLoaded());
  }
}
