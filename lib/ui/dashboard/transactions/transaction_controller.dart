import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mindmap_app/api_calls/api_service.dart';
import 'package:mindmap_app/beans/response_pojo/GetTransactionResponse.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/common_functions.dart';
import 'package:mindmap_app/utils/data_map_service.dart';
import 'dart:async';


class TransactionController extends GetxController {
  var dataMapService = DataMapService();
  var commonFunctions = CommonFunctions();
  final dio = Dio();
  var posts = <GetTransactionResponse>[].obs;

  @override
  void onInit() async {
    apiCall();
    super.onInit();

  }

  void apiCall() async {
    getTransactionListApiCall();
  }


  getTransactionListApiCall() async {
    try {
      final responseData = await ApiService(dio).getTransactionListCall();
      posts.value = responseData;
    } catch (err) {
      Get.snackbar(StringConstants.APP_NAME, StringConstants.SOME_THING_WRONG, snackPosition: SnackPosition.TOP, backgroundColor: MindMapColors.colorRed, colorText: MindMapColors.colorWhite);
    }
  }


  Future<void> waitForSeconds(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }

}