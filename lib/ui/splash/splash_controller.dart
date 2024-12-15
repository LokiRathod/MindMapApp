import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/utils/all_constants/store_data_constants.dart';
import 'package:mindmap_app/utils/app_navigation.dart';
import 'dart:async';
import 'package:mindmap_app/utils/storage_service.dart';



class SplashController extends GetxController {
  final storageService = StorageService();
  final appNavigation = AppNavigation();
  var box = GetStorage();
  var username;

  @override
  void onInit() async {
    checkValidation();
    super.onInit();
  }

  void checkValidation() async {
    username = storageService.readString(StoreDataConstants.USER_NAME) ?? "";
    if (username.toString().isEmpty) {
      await waitForSeconds(2);
      appNavigation.goToLogInScreen();
    } else {
      appNavigation.goToHomeScreen();
    }
  }

  Future<void> waitForSeconds(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }

}