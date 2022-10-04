
import 'dart:convert';

FeasibilityTypeModel feasibilityTypeFromJson(String str) =>
    FeasibilityTypeModel.fromJson(json.decode(str));

String feasibilityTypeToJson(FeasibilityTypeModel data) =>
    json.encode(data.toJson());

class FeasibilityTypeModel {
  FeasibilityTypeModel({
    this.status,
    this.message,
    this.code,
    this.feasibilityType,
  });

  bool? status;
  String? message;
  int? code;
  List<FeasibilityTypeElement>? feasibilityType;

  factory FeasibilityTypeModel.fromJson(Map<String, dynamic> json) =>
      FeasibilityTypeModel(
        status: json["status"],
        message: json["message"],
        code: json["code"],
        feasibilityType: List<FeasibilityTypeElement>.from(
            json["FeasibilityType"]
                .map((x) => FeasibilityTypeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "code": code,
        "FeasibilityType":
            List<dynamic>.from(feasibilityType!.map((x) => x.toJson())),
      };
}

class FeasibilityTypeElement {
  FeasibilityTypeElement({
    this.id,
    this.type,
    this.img,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? type;
  String? img;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FeasibilityTypeElement.fromJson(Map<String, dynamic> json) =>
      FeasibilityTypeElement(
        id: json["id"],
        type: json["type"],
        img: json["img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "img": img,
        "created_at":
            "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updated_at":
            "${updatedAt!.year.toString().padLeft(4, '0')}-${updatedAt!.month.toString().padLeft(2, '0')}-${updatedAt!.day.toString().padLeft(2, '0')}",
      };
}
