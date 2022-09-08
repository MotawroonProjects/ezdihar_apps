part of 'offer_page_cubit.dart';

@immutable
abstract class OfferPageState {}

class OfferPageInitial extends OfferPageState {}

class OnDataValid extends OfferPageState {}

class OnNegotiableChanged extends OfferPageState {
  bool isChecked;
  OnNegotiableChanged(this.isChecked);
}

class OnInterviewChanged extends OfferPageState {
  bool isChecked;

  OnInterviewChanged(this.isChecked);
}

class OnCallChanged extends OfferPageState {
  bool isChecked;

  OnCallChanged(this.isChecked);
}
