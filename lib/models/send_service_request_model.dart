class SendServiceRequestModel {
  String dateOfBirth = '';
  String price = '';
  String detials = '';
  int category_id = 0;
  int room_id = 0;
  int user_id = 0;

  bool isDataValid() {
    return dateOfBirth.isNotEmpty && price.isNotEmpty && detials.isNotEmpty;
  }
}
