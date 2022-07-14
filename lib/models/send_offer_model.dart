import 'dart:ui';

class SendOfferModel {
  String amount = '';
  String percentage = '';
  String advantage = '';
  String address = 'ggg';
  String lat = '';
  String lng = '';
  bool isNegotiable = false;
  bool isInterView = false;
  bool isVoiceCall = false;

  bool isDataValid() {
    print('Data=>${amount+'___'+percentage+'___'+advantage+'___'+address}');

    if (amount.isNotEmpty &&
        percentage.isNotEmpty &&
        advantage.isNotEmpty &&
        address.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
