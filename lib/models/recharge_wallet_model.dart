// To parse this JSON data, do
//
//     final rechargeWalletModel = rechargeWalletModelFromJson(jsonString);

import 'dart:convert';

RechargeWalletModel rechargeWalletModelFromJson(String str) => RechargeWalletModel.fromJson(json.decode(str));

String rechargeWalletModelToJson(RechargeWalletModel data) => json.encode(data.toJson());

class RechargeWalletModel {
  RechargeWalletModel({
    this.data,
    this.message,
    this.code,
  });

  final WalletData? data;
  final String? message;
  final int? code;

  factory RechargeWalletModel.fromJson(Map<String, dynamic> json) => RechargeWalletModel(
    data: WalletData.fromJson(json["data"]),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
    "code": code,
  };
}

class WalletData {
  String payment_url='';
  // WalletData({
  //   this.payData,
  // });
  //
  // final PayData? payData;

  WalletData.fromJson(Map<String, dynamic> json) {

    payment_url =
    json['payment_url'] != null ? json['payment_url'] as String : '';

    }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_url'] = this.payment_url;

    return data;
  }
  }






class PayData {
  PayData({
    this.id,
    this.object,
    this.liveMode,
    this.apiVersion,
    this.method,
    this.status,
    this.amount,
    this.currency,
    this.threeDSecure,
    this.cardThreeDSecure,
    this.saveCard,
    this.product,
    this.statementDescriptor,
    this.description,
    this.transaction,
    this.autoReversed,
  });

  final String? id;
  final String? object;
  final bool? liveMode;
  final String? apiVersion;
  final String? method;
  final String? status;
  final int? amount;
  final String? currency;
  final bool? threeDSecure;
  final bool? cardThreeDSecure;
  final bool? saveCard;
  final String? product;
  final String? statementDescriptor;
  final String? description;
  final Transaction? transaction;
  final bool? autoReversed;

  factory PayData.fromJson(Map<String, dynamic> json) => PayData(
    id: json["id"],
    object: json["object"],
    liveMode: json["live_mode"],
    apiVersion: json["api_version"],
    method: json["method"],
    status: json["status"],
    amount: json["amount"],
    currency: json["currency"],
    threeDSecure: json["threeDSecure"],
    cardThreeDSecure: json["card_threeDSecure"],
    saveCard: json["save_card"],
    product: json["product"],
    statementDescriptor: json["statement_descriptor"],
    description: json["description"],
    transaction: Transaction.fromJson(json["transaction"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "live_mode": liveMode,
    "api_version": apiVersion,
    "method": method,
    "status": status,
    "amount": amount,
    "currency": currency,
    "threeDSecure": threeDSecure,
    "card_threeDSecure": cardThreeDSecure,
    "save_card": saveCard,
    "product": product,
    "statement_descriptor": statementDescriptor,
    "description": description,
    "transaction": transaction!.toJson(),
  };
}

class Activity {
  Activity({
    this.id,
    this.object,
    this.created,
    this.status,
    this.currency,
    this.amount,
    this.remarks,
  });

  final String? id;
  final String? object;
  final int? created;
  final String? status;
  final String? currency;
  final int? amount;
  final String? remarks;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    object: json["object"],
    created: json["created"],
    status: json["status"],
    currency: json["currency"],
    amount: json["amount"],
    remarks: json["remarks"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "status": status,
    "currency": currency,
    "amount": amount,
    "remarks": remarks,
  };
}


class Phone {
  Phone({
    this.countryCode,
    this.number,
  });

  final String? countryCode;
  final String? number;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    countryCode: json["country_code"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "country_code": countryCode,
    "number": number,
  };
}








class Transaction {
  Transaction({
    this.timezone,
    this.created,
    this.url,
    this.expiry,
    this.asynchronous,
    this.amount,
    this.currency,
  });

  final String? timezone;
  final String? created;
  final String? url;
  final Expiry? expiry;
  final bool? asynchronous;
  final int ?amount;
  final String? currency;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    timezone: json["timezone"],
    created: json["created"],
    url: json["url"],
    expiry: Expiry.fromJson(json["expiry"]),
    asynchronous: json["asynchronous"],
    amount: json["amount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "timezone": timezone,
    "created": created,
    "url": url,
    "expiry": expiry!.toJson(),
    "asynchronous": asynchronous,
    "amount": amount,
    "currency": currency,
  };
}

class Expiry {
  Expiry({
    this.period,
    this.type,
  });

  final int? period;
  final String? type;

  factory Expiry.fromJson(Map<String, dynamic> json) => Expiry(
    period: json["period"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "period": period,
    "type": type,
  };
}
