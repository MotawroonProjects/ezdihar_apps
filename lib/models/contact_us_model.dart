// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) =>
    ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  ContactUsModel({
    this.status,
    this.message,
    this.code,
    this.contact,
  });

  bool? status;
  String? message;
  int? code;
  ContactModel? contact;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        contact: ContactModel.fromJson(json["contact"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "contact": contact!.toJson(),
      };
}

class ContactModel {
  ContactModel({
    this.id,
    this.name,
    this.email,
    this.subject,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  String? subject;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        subject: json["subject"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "subject": subject,
        "message": message,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}
