import 'package:ezdihar_apps/models/status_resspons.dart';

class SliderModel {
  late List<String> images = [];
  late StatusResponse status;

  SliderModel.fromJson(Map<String, dynamic> json) {
    images = [];
    status = StatusResponse.fromJson(json);
    json['data'].forEach((v)=>images.add(v['image']));
  }
}
