import 'dart:convert';

import 'package:ezdihar_apps/models/user.dart';
import 'package:ezdihar_apps/models/user_model.dart';

MainOrdersModel providerOrderFromJson(String str) =>
    MainOrdersModel.fromJson(json.decode(str));

String providerOrderToJson(MainOrdersModel data) => json.encode(data.toJson());

class MainOrdersModel {
  MainOrdersModel({
    required this.status,
    required this.message,
    required this.code,
    required this.orders,
  });

  late bool status;
  late String message;
  late int code;
  late List<ProviderOrder> orders;

  factory MainOrdersModel.fromJson(Map<String, dynamic> json) =>
      MainOrdersModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        orders: json["orders"] != null
            ? List<ProviderOrder>.from(
                json["orders"].map(
                  (x) => ProviderOrder.fromJson(x),
                ),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class ProviderOrder {
  ProviderOrder({
    required this.id,
    required this.status,
    required this.details,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.subCategory,
  });

  late final int id;
  late final String status;
  late final String details;
  late final String img;
  late final DateTime createdAt;
  late final DateTime updatedAt;
  late final UserModel user;
  late final SubCategoryOrders subCategory;

  factory ProviderOrder.fromJson(Map<String, dynamic> json) => ProviderOrder(
        id: json["id"],
        status: json["status"],
        details: json["details"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"] != null ? UserModel.fromJson(json["user"]) : UserModel(),
        subCategory: SubCategoryOrders.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "details": details,
        "img": img,
        "created_at":
            "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt.year.toString().padLeft(4, '0')}-${updatedAt.month.toString().padLeft(2, '0')}-${updatedAt.day.toString().padLeft(2, '0')}",
        "user": UserModel.toJson,
        "sub_category": subCategory.toJson(),
      };
}

class SubCategoryOrders {
  SubCategoryOrders({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.terms,
    required this.price,
    required this.image,
  });

  late int id;
  late int categoryId;
  late String title;
  late String terms;
  late int price;
  late String image;

  factory SubCategoryOrders.fromJson(Map<String, dynamic> json) =>
      SubCategoryOrders(
        id: json["id"],
        categoryId: json["category_id"]??0,
        title: json["title"]??"",
        terms: json["terms"]??"",
        price: json["price"]??0,
        image: json["image"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "terms": terms,
        "price": price,
        "image": image,
      };
}
