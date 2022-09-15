import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/contact_us_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsModel model = ContactUsModel();
  ContactUsCubit() : super(ContactUsInitial());
  void checkData(){
    if(model.isDataValid()){
      emit(OnDataValid());
    }else{
      emit(ContactUsInitial());
    }
  }

   send(BuildContext context) {

   }

}
