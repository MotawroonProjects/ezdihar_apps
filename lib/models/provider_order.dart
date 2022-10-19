import 'dart:convert';

import 'package:ezdihar_apps/models/user.dart';
import 'package:ezdihar_apps/models/user_model.dart';

MainOrdersModel providerOrderFromJson(String str) =>
    MainOrdersModel.fromJson(json.decode(str));

String providerOrderToJson(MainOrdersModel data) => json.encode(data.toJson());

class MainOrdersModel {
  MainOrdersModel({
    required this.message,
    required this.code,
    required this.orders,
  });

  late String message;
  late int code;
  late List<ProviderOrder> orders;

  factory MainOrdersModel.fromJson(Map<String, dynamic> json) =>
      MainOrdersModel(
        message: json["message"],
        code: json["code"],
        orders: json["service_requests"] != null
            ? List<ProviderOrder>.from(
                json["service_requests"].map(
                  (x) => ProviderOrder.fromJson(x),
                ),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "service_requests": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class ProviderOrder {
  ProviderOrder(
      {required this.id,
      required this.price,
      required this.details,
      required this.delivery_date,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
      required this.subCategory,
      required this.status});

  late final int id;
  late final String status;
  late final String details;
  late final String img;
  late String price;
  late String delivery_date;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final UserModel user;
  late final SubCategory subCategory;

  factory ProviderOrder.fromJson(Map<String, dynamic> json) => ProviderOrder(
        id: json["id"],
        status: json["status"],
        details: json["details"],
        price: json["price"],
        delivery_date: json["delivery_date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] != null
            ? UserModel.fromJson(json["user"])
            : UserModel(),
        subCategory: SubCategory.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "details": details,
        "price": price,
        "delivery_date": delivery_date,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "user": UserModel.toJson,
        "sub_category": subCategory.toJson(),
      };
}
