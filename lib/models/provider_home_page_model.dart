// To parse this JSON data, do
//
//     final providerHomePageModel = providerHomePageModelFromJson(jsonString);

import 'dart:convert';

ProviderHomePageModel providerHomePageModelFromJson(String str) => ProviderHomePageModel.fromJson(json.decode(str));

String providerHomePageModelToJson(ProviderHomePageModel data) => json.encode(data.toJson());

class ProviderHomePageModel {
  ProviderHomePageModel({
    this.status,
    this.message,
    this.code,
    this.orders,
  });

  final bool? status;
  final String? message;
  final int? code;
  final Orders? orders;

  factory ProviderHomePageModel.fromJson(Map<String, dynamic> json) => ProviderHomePageModel(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    orders: Orders.fromJson(json["orders"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "orders": orders!.toJson(),
  };
}

class Orders {
  Orders({
    this.orders,
    this.ordersMonth,
    this.totalUsers,
    this.usersMonth,
  });

  final int? orders;
  final int? ordersMonth;
  final int? totalUsers;
  final int? usersMonth;

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    orders: json["orders"],
    ordersMonth: json["orders_month"],
    totalUsers: json["total_users"],
    usersMonth: json["users_month"],
  );

  Map<String, dynamic> toJson() => {
    "orders": orders,
    "orders_month": ordersMonth,
    "total_users": totalUsers,
    "users_month": usersMonth,
  };
}
