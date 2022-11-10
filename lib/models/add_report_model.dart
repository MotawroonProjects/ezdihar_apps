import 'dart:ui';

import 'package:ezdihar_apps/models/consultant_type_model.dart';

class AddReportModel {
  String photo = '';
  String reason = '';
  String details = '';
  int provider_id = 0;
  int order_id = 0;
  int user_id = 0;

  bool isDataValid() {
    if (reason.isNotEmpty && details.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
