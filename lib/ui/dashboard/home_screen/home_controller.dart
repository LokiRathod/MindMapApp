import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/ui/login/user_login/login_screen.dart';
import 'package:mindmap_app/utils/all_constants/store_data_constants.dart';
import 'package:mindmap_app/utils/app_navigation.dart';
import 'package:mindmap_app/utils/common_functions.dart';
import 'dart:async';
import 'package:mindmap_app/utils/storage_service.dart';



class HomeController extends GetxController {
  var storageService = StorageService();
  var appNavigation = AppNavigation();
  var commonFunctions = CommonFunctions();
  var box = GetStorage();
  var username = ''.obs;

  var showBalance = true.obs;
  var balance = 500.00.obs;
  var balanceVisible = true.obs;


  @override
  void onInit() async {
    checkValidation();
    super.onInit();
  }

  void checkValidation() async {
    username.value = storageService.readString(StoreDataConstants.USER_NAME) ?? "";
  }


}