class StatusResponse{
  late int code =0;
  late String message="";

  StatusResponse();
  StatusResponse.fromJson(Map<String,dynamic> json){
    code = json['code']!=null ?json['code']:0;
    message = json ['message']!=null?json ['message'].toString():"";
  }

}