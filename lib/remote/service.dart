import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezdihar_apps/constants/app_constant.dart';
import 'package:ezdihar_apps/models/category_data_model.dart';
import 'package:ezdihar_apps/models/city_data_model.dart';
import 'package:ezdihar_apps/models/consultant_data_model.dart';
import 'package:ezdihar_apps/models/consultants_data_model.dart';
import 'package:ezdihar_apps/models/home_model.dart';
import 'package:ezdihar_apps/models/login_model.dart';
import 'package:ezdihar_apps/models/send_general_study_model.dart';
import 'package:ezdihar_apps/models/slider_model.dart';
import 'package:ezdihar_apps/models/status_resspons.dart';
import 'package:ezdihar_apps/models/user_data_model.dart';
import 'package:ezdihar_apps/models/user_sign_up_model.dart';
import 'package:ezdihar_apps/remote/handle_exeption.dart';
import 'package:ezdihar_apps/screens/home_page/navigation_screens/main_screen/cubit/main_page_cubit.dart';
import 'package:ezdihar_apps/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

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

  Future<ProjectsDataModel> getHomeData(
      String user_token, String type, String? date, int category_id) async {
    try {
      Response response;
      BaseOptions baseOptions = dio.options;
      CancelToken cancelToken = CancelToken();
      if (user_token.isNotEmpty) {
        baseOptions.headers = {'Authorization': user_token};
        dio.options = baseOptions;
      } else {
        baseOptions.headers = {'Content-Type': 'application/json'};
        dio.options = baseOptions;
      }

      response = await dio.get(
          'api/home/index?type=${type}&date=${date}&category_id=${category_id == 0 ? "All" : category_id}',
          cancelToken: cancelToken);

      if (!cancelToken.isCancelled) {
        cancelToken.cancel();
      }

      return ProjectsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
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
      var fields = FormData.fromMap(
          {'phone_code': loginModel.phone_code, 'phone': loginModel.phone});

      Response response = await dio.post('api/auth/login', data: fields);

      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<UserDataModel> signUp(UserSignUpModel model) async {
    var fields = FormData.fromMap({});
    try {
      if (model.imagePath.isNotEmpty) {
        fields = FormData.fromMap({
          'first_name': model.firstName,
          'last_name': model.lastName,
          'email': model.email,
          'phone_code': model.phone_code,
          'phone': model.phone,
          'city_id': model.cityId,
          'birthdate': model.dateOfBirth,
          'image': await MultipartFile.fromFile(model.imagePath)
        });
      } else {
        fields = FormData.fromMap({
          'first_name': model.firstName,
          'last_name': model.lastName,
          'email': model.email,
          'phone_code': model.phone_code,
          'phone': model.phone,
          'city_id': model.cityId,
          'birthdate': model.dateOfBirth,
        });
      }

      Response response = await dio.post('api/auth/register', data: fields);
      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<StatusResponse> love_follow_report(
      String user_token, int post_id, String type) async {
    var fields = FormData.fromMap({'post_id': post_id, 'type': type});
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response =
          await dio.post('api/profile/love-report-follow-post', data: fields);
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<ProjectsDataModel> getMyFavorites(String user_token) async {
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;

      Response response = await dio.get('api/profile/likedPost');
      return ProjectsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ProjectsDataModel> getMyPosts(String user_token) async {
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;

      Response response = await dio.get('api/profile/myPosts');
      return ProjectsDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<StatusResponse> updateFireBaseToken(
      String user_token, firebaseToken, String type) async {
    var fields = FormData.fromMap({'token': firebaseToken, 'type': type});
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response = await dio.post('api/auth/insertToken', data: fields);
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<StatusResponse> logout(String user_token, firebaseToken) async {
    var fields = FormData.fromMap({'token': firebaseToken});
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response = await dio.post('api/auth/logout', data: fields);
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<UserDataModel> updateProfile(UserSignUpModel model,String user_token) async {
    var fields = FormData.fromMap({});
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;

      if (model.imagePath.isNotEmpty&&!model.imagePath.startsWith('http')) {
        fields = FormData.fromMap({
          'first_name': model.firstName,
          'last_name': model.lastName,
          'email': model.email,
          'phone_code': model.phone_code,
          'phone': model.phone,
          'city_id': model.cityId,
          'birthdate': model.dateOfBirth,
          'image': await MultipartFile.fromFile(model.imagePath)
        });
      } else {
        fields = FormData.fromMap({
          'first_name': model.firstName,
          'last_name': model.lastName,
          'email': model.email,
          'phone_code': model.phone_code,
          'phone': model.phone,
          'city_id': model.cityId,
          'birthdate': model.dateOfBirth,
        });
      }

      Response response = await dio.post('api/auth/updateProfile', data: fields);
      return UserDataModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<StatusResponse> addPost(String user_token,SendGeneralStudyModel model) async {
    BaseOptions baseOptions = dio.options;

    baseOptions.headers = {'Authorization': user_token};
    dio.options = baseOptions;

    var fields = FormData.fromMap({});
    try {

      fields = FormData.fromMap({
        'title': model.projectName,
        'text': model.details,
        'category_id': model.category_id,
        'consultants_ids[]': model.consultantTypes,
        'is_investment':model.showProjectInvestment?1:0,
        'image': await MultipartFile.fromFile(model.project_photo_path)
      });

      Response response = await dio.post('api/post/storePost', data: fields);
      print("data=>${response.data.toString()}");
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }

  Future<SliderModel> getSliders() async {
    try {
      print('slider');
      Response response = await dio.get('api/home/slider');
      return SliderModel.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<StatusResponse> deleteProject(String user_token, int post_id) async {
    var fields = FormData.fromMap({'post_id': post_id});
    try {
      BaseOptions options = dio.options;
      options.headers = {'Authorization': user_token};
      dio.options = options;
      Response response =
      await dio.post('api/post/deletePost', data: fields);
      return StatusResponse.fromJson(response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('Error=>${errorMessage}');

      throw errorMessage;
    }
  }
}
