import 'package:dio/dio.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/remote/handle_exeption.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';

class ServiceApi {
  late Dio dio;

  ServiceApi() {
    BaseOptions baseOptions = BaseOptions(
        baseUrl: AppConstant.baseUrl,
        connectTimeout: 1000 * 60 * 2,
        receiveTimeout: 1000 * 60 * 2,
        receiveDataWhenStatusError: true,
        contentType: "application/json",
        headers: {'Content-Type': 'application/json'});
    dio = Dio(baseOptions);
  }

  Future<HomeModel> getHomeData(
      String user_token, String type, String? date, int category_id) async {
    try {
      Response response;
      BaseOptions baseOptions = dio.options;
      CancelToken cancelToken = CancelToken();
      if (user_token.isNotEmpty) {
        baseOptions.headers = {'Authorization': user_token};
        dio.options = baseOptions;
      }

      response = await dio.get('api/home/index?type=${type}&date=${date}&category_id=${category_id == 0 ? "All" : category_id}',
          cancelToken: cancelToken);

      if (!cancelToken.isCancelled) {
        cancelToken.cancel();
      }

      return HomeModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print("object${errorMessage}");

      throw errorMessage;
    }
  }

  Future<CategoryDataModel> getCategory() async {
    try {
      Response response;
      response = await dio.get('api/home/categories');
      return CategoryDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ConsultantDataModel> getConsultantTypes() async {
    try {
      Response response;
      response = await dio.get('api/home/typesOfAdvisors');
      return ConsultantDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
