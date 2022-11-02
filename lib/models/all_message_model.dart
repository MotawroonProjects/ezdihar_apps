import 'package:ezdihar_apps/models/message_model.dart';
import 'package:ezdihar_apps/models/provider_home_page_model.dart';
import 'package:ezdihar_apps/models/provider_order.dart';

class AllMessageModel {
  late int id;
  late int user_id;
  late String adviser_id;
  late String post_id;
  late String is_end;
  late List<MessageModel> messages;
  late List<ProviderOrder> services;

  AllMessageModel();

  AllMessageModel.fromJson(Map<String, dynamic> json) {
    messages = [];
    services = [];
    json['messages'].forEach((d) => messages.add(MessageModel.fromJson(d)));
    json['services'].forEach((d) => services.add(ProviderOrder.fromJson(d)));

    id = json['id'] != null ? json['id'] as int : 0;
    user_id = json['user_id'] != null ? json['user_id'] as int : 0;
    adviser_id = json['adviser_id'] != null ? json['adviser_id'] as String : "";
    post_id = json['post_id'] != null ? json['post_id'] as String : "";
    is_end = json['is_end'] != null ? json['is_end'] as String : "";
  }
}
