// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  SettingModel({
    this.data,
    this.message,
    this.code,
  });

  final SettingData? data;
  final String? message;
  final int? code;

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
    data: SettingData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "code": code,
  };
}

class SettingData {
  SettingData({
    this.id,
    this.aboutAr,
    this.aboutEn,
    this.termsAr,
    this.termsEn,
    this.privacyAr,
    this.privacyEn,
    this.facebook,
    this.instagram,
    this.twitter,
    this.snapchat
  });

  final int? id;
  final String? aboutAr;
  final String? aboutEn;
  final String? termsAr;
  final String? termsEn;
  final String? privacyAr;
  final String? privacyEn;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? snapchat;

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
    id: json["id"],
    aboutAr: json["about_ar"],
    aboutEn: json["about_en"],
    termsAr: json["terms_ar"],
    termsEn: json["terms_en"],
    privacyAr: json["privacy_ar"],
    privacyEn: json["privacy_en"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    snapchat: json["snapchat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "about_ar": aboutAr,
    "about_en": aboutEn,
    "terms_ar": termsAr,
    "terms_en": termsEn,
    "privacy_ar": privacyAr,
    "privacy_en": privacyEn,
    "facebook": facebook,
    "instagram": instagram,
    "twitter": twitter,
    "snapchat": snapchat,
  };
}
