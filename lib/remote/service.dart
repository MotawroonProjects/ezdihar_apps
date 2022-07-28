import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/consultants_data_model.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
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

      response = await dio.get(
          'api/home/index?type=${type}&date=${date}&category_id=${category_id == 0 ? "All" : category_id}',
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

  Future<ConsultantsDataModel> getConsultants(int consultant_type_id) async {
    try {
      Response response = await dio.get('api/home/advisorsByType',
          queryParameters: {'type_id': consultant_type_id});
      print("response:${response.data.toString()}");
      return ConsultantsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserDataModel> getConsultantDetails(int consultant_id) async {
    try {
      Response response = await dio.get('api/home/oneAdvisor',
          queryParameters: {'advisor_id': consultant_id});
      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<CityDataModel> getCities() async {
    try {
      Response response = await dio.get('api/home/cities');
      return CityDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserDataModel> login(LoginModel loginModel) async {
    try {
      var fields = FormData.fromMap({
        'phone_code':loginModel.phone_code,
        'phone':loginModel.phone
      });

      Response response = await dio.post('api/auth/login',data: fields);
      print("response=>${response.data.toString()}");

      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserDataModel> signUp(UserSignUpModel model) async {
    var fields = FormData.fromMap({});
    try {
      if(model.imagePath.isNotEmpty){
        print('imagePath=>${model.imagePath}');

        fields = FormData.fromMap({
          'first_name':model.firstName,
          'last_name':model.lastName,
          'email':model.email,
          'phone_code':model.phone_code,
          'phone':model.phone,
          'city_id':model.cityId,
          'birthdate':model.dateOfBirth,
          'image':await MultipartFile.fromFile(model.imagePath)

        });
      }else{
        print('data=>');

        fields = FormData.fromMap({
          'first_name':model.firstName,
          'last_name':model.lastName,
          'email':model.email,
          'phone_code':model.phone_code,
          'phone':model.phone,
          'city_id':model.cityId,
          'birthdate':model.dateOfBirth,
        });
      }

      Response response = await dio.post('api/auth/register',data: fields);
      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }


}
