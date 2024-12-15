import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mindmap_app/beans/request_pojo/SignInRequest.dart';
import 'package:mindmap_app/utils/all_constants/store_data_constants.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/app_navigation.dart';
import 'package:mindmap_app/utils/data_map_service.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/network_connection.dart';
import 'package:mindmap_app/utils/storage_service.dart';




class LogInController extends GetxController {
  final dataMapService = DataMapService();
  var appNavigation = AppNavigation();
  final storageService = StorageService();
  final dio = Dio();
  late TextEditingController passwordTextController, userNameTextController;
  var passwordText = false.obs;
  var userNameText = false.obs;
  var passwordVisible = true.obs;
  var isLogInButtonDisabled = true.obs;

  @override
  void onInit() {
    userNameTextController = TextEditingController();
    passwordTextController = TextEditingController();

    super.onInit();
    userNameTextController.addListener(validateForm);
    passwordTextController.addListener(validateForm);
  }


  void validateForm() {
    if(userNameTextController.text.length > 2 && passwordTextController.text.length > 3){
      isLogInButtonDisabled.value = false;
    } else {
      isLogInButtonDisabled.value = true;
    }
  }


  @override
  void onClose() {
    // userNameTextController.dispose();
    // passwordTextController.dispose();
    super.onClose();
  }


  Future<void> checkValidation() async {
    if (NetworkConnection().connected) {
      try {
        final request = SignInRequest();
        request.username = userNameTextController.text;
        request.password = userNameTextController.text;
        navigateToHomeScreen();
      } catch (e) {
        Get.snackbar(
          StringConstants.APP_NAME,
          StringConstants.SOME_THING_WRONG,
          snackPosition: SnackPosition.TOP,
          backgroundColor: MindMapColors.colorRed,
          colorText: MindMapColors.colorWhite,
        );
      }
    } else {
      Get.snackbar(StringConstants.APP_NAME, StringConstants.NO_INTERNET);
    }
  }



  navigateToHomeScreen() {
    //Save all the needed data
    saveUserData();
    appNavigation.goToHomeScreen();
  }


  saveUserData() async {
    storageService.saveString(StoreDataConstants.USER_NAME, userNameTextController.text);
  }

}
