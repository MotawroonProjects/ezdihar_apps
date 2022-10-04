import 'package:ezdihar_apps/models/user.dart';

class MessageModel {
  late int from_user_id;
  late int to_user_id;
  late String type;
  late String message;
  late String file;
  late String date;
  late String time;
  late User from_user;
  late User to_user;


  MessageModel();
  MessageModel.fromJson(Map<String, dynamic> json) {
    from_user_id =
        json['from_user_id'] != null ? json['from_user_id'] as int : 0;
    to_user_id = json['to_user_id'] != null ? json['to_user_id'] as int : 0;
    type = json['type'] != null ? json['type'] as String : "";
    message = json['message'] != null ? json['message'] as String : "";
    file = json['file'] != null ? json['file'] as String : "";
    date = json['date'] != null ? json['date'] as String : "";
    time = json['time'] != null ? json['time'] as String : "";
    from_user =
        json['from_user'] != null ? User.fromJson(json['from_user']) : User();
    to_user = json['to_user'] != null ? User.fromJson(json['to_user']) : User();
  }
}
