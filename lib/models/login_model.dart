class LoginModel{
  String phone_code = '+966';
  String phone ='';



  bool isDataValid(){
    return phone_code.isNotEmpty && phone.isNotEmpty;
  }
}