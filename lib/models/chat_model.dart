import 'package:ezdihar_apps/models/message_model.dart';
import 'package:ezdihar_apps/models/user.dart';

class ChatModel {
  late int id;
  late int user_id;
  late String adviser_id;
  late String post_id;
  late String is_end;
  late User user;
  late User provider;
   MessageModel? latest_message;
  ChatModel();

  ChatModel.fromJson(Map<String,dynamic> json){

    id = json['id']!=null?json['id'] as int:0;
    user_id = json['user_id']!=null?json['user_id'] as int:0;
    adviser_id = json['adviser_id']!=null?json['adviser_id'] as String:"";
    post_id = json['post_id']!=null?json['post_id'] as String:"";
    is_end = json['is_end']!=null?json['is_end'] as String:"";
    user =
    json['user'] != null ? User.fromJson(json['user']) : User();
    provider = json['provider'] != null ? User.fromJson(json['provider']) : User();
    latest_message = json['latest_message'] != null ? MessageModel.fromJson(json['latest_message']) : null;

  }
}
