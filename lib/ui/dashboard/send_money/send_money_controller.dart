import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mindmap_app/api_calls/api_service.dart';
import 'package:mindmap_app/beans/request_pojo/SendMoneyRequest.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/common_functions.dart';
import 'package:mindmap_app/utils/network_connection.dart';



class SendMoneyController extends GetxController {
  var commonFunctions = CommonFunctions();
  final dio = Dio();
  late BuildContext context;
  var username = ''.obs;

  final TextEditingController amountTextController = TextEditingController();


  var sendToUserList = <String>['Kumar', 'Lokesh', 'Rathod', 'MindMap'].obs;
  var selectedToItem = ''.obs;
  var selectedToIndex = 0.obs;
  var isButtonDisabled = true.obs;


  @override
  void onInit() async {
    context = Get.context!;
    super.onInit();
    amountTextController.addListener(validateForm);
  }


  checkValidation() async{
    if (NetworkConnection().connected) {
      try {
        final request = SendMoneyRequest();
        request.title = "Send a money";
        request.body = "Send a money to the Mind map";
        request.userId = 101;
        final responseData = await ApiService(dio).sendMoneyCall(request);
        print(responseData);
        // Show success/failure UI
        Get.bottomSheet(
          bottomSheetContainer(),
        );

      } catch (error) {
        Get.snackbar(StringConstants.APP_NAME, StringConstants.SOME_THING_WRONG, snackPosition: SnackPosition.TOP, backgroundColor: MindMapColors.colorRed, colorText: MindMapColors.colorWhite);
      }
    } else {
      Get.snackbar(StringConstants.APP_NAME, StringConstants.NO_INTERNET);
    }
  }

  Widget bottomSheetContainer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0,),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.check_circle, size: 66.0, color: MindMapColors.colorGreen60,),
              ),
              const SizedBox(height: 20.0,),
              Text(StringConstants.TRANSACTION_SUCCESSFULLY,
                  style: TextStylesConstants.textStyleBoldBlack_18),
              const SizedBox(height: 20.0,),
              Text(StringConstants.TRANSACTION_SUCCESSFULLY_MSG,
                  style: TextStylesConstants.textStyleBoldBlack_14),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text(StringConstants.CLOSE, style: TextStylesConstants.textStyleBoldBlack_14),
              ),
            ],
          ),
        ),
      );
  }



  toSelectedUserItem(String? newValue) {
    selectedToItem.value = newValue!;
    print("Selected Name : ${selectedToItem.value}");
  }

  void validateForm() {
    if(amountTextController.text.length > 1){
      isButtonDisabled.value = false;
    } else {
      isButtonDisabled.value = true;
    }
  }


}