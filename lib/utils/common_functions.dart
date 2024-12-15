import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/api_calls/api_service.dart';
import 'package:mindmap_app/beans/response_pojo/ErrorResponse.dart';
import 'package:mindmap_app/ui/login/user_login/login_screen.dart';
import 'package:mindmap_app/utils/all_constants/store_data_constants.dart';
import 'package:mindmap_app/utils/data_map_service.dart';
import 'package:mindmap_app/utils/loader_dialog.dart';
import 'package:mindmap_app/utils/storage_service.dart';
import 'package:intl/intl.dart';



class CommonFunctions {
  final dataMapService = DataMapService();
  final storageService = StorageService();
  late Dio dio;
  late ApiService apiClient;
  var box = GetStorage();


  currencyNumberFormat(amount) {
    var formattedAmount = NumberFormat.currency(locale: 'en_US', symbol: '\$',).format(amount);
    return formattedAmount;
  }

  apiDio() {
    dio = Dio();
    apiClient = ApiService(dio);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  void showLoader() {
    Get.dialog(LoaderDialog());
  }

  void hideLoader() {
    Get.back();
  }


  void apiErrorCode(ErrorResponse responseData, BuildContext context) {
    if (responseData.code == 401) {
      logoutCall();
    }
  }

  logoutCall() async {
    var box = GetStorage();
    box.erase();
    Get.offAll(() => const LogInScreen());
  }


  saveUserData(var responseData) async {
    storageService.saveString(StoreDataConstants.USER_NAME, responseData.data!.userName ?? "");

  }



}