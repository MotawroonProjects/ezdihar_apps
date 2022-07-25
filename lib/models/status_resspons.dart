class StatusResponse{
  late int code =0;
  late String message="";

  StatusResponse();
  StatusResponse.fromJson(Map<String,dynamic> json){
    code = json['code'] as int;
    message = json ['message'].toString();
  }

}