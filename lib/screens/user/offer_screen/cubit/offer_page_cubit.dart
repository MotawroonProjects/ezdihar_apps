import 'package:bloc/bloc.dart';
import 'package:ezdihar_apps/models/send_offer_model.dart';
import 'package:meta/meta.dart';


part 'offer_page_state.dart';

class OfferPageCubit extends Cubit<OfferPageState> {
  SendOfferModel model = SendOfferModel();
  OfferPageCubit() : super(OfferPageInitial());

  void checkData(){
    if(model.isDataValid()){
      emit(OnDataValid());
    }else{
      emit(OfferPageInitial());
    }
  }

  void updateNegotiableValue(bool value){
    model.isNegotiable = value;
    emit(OnNegotiableChanged(model.isNegotiable));

  }

  void updateInterviewValue(bool value){
    model.isInterView = value;
    emit(OnInterviewChanged(model.isInterView));
  }

  void updateCallValue(bool value){
    model.isVoiceCall = value;
    emit(OnCallChanged(model.isVoiceCall));
  }

}
