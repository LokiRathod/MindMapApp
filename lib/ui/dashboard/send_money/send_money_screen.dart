import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/send_money/send_money_controller.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/custom_widgets/currency_input_formatter.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_app_bar_action.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_button.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final SendMoneyController _sendMoneyController = Get.put(SendMoneyController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MindMapColors.colorPrimary,
      appBar: CustomAppBar(
        title: StringConstants.SEND_MONEY,
        color: MindMapColors.colorApp,
        onBackPressed: () {Get.back();},
        onPressed: () {_sendMoneyController.commonFunctions.logoutCall();},
      ),
      body: Container(
        color: MindMapColors.colorWhite,
        child: Column(
          children: [
            const SizedBox(height: 25.0,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _sendToView(context),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _amountView(context),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
              child: _sendButtonAction(context),
            )
          ],
        ),
      ),
    );
  }



  Widget _sendToView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(StringConstants.SEND_TO_,
            style: TextStylesConstants.textStyleBoldAppColor_16,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 15.0,),
          Obx(() => Container(width: MediaQuery.of(context).size.width, height: 50,
            margin: const EdgeInsets.only(top: 0.0, right: 5),
            decoration: BoxDecoration(color: MindMapColors.colorBlack10, borderRadius: BorderRadius.circular(5),),
            child: DropdownButtonHideUnderline(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 18),
                child: DropdownButton(
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: MindMapColors.colorBlack,),
                  hint: Text(StringConstants.SELECT_ACCOUNT,
                    style: TextStylesConstants.textStyleBlack_14,
                    textAlign: TextAlign.start,
                  ),
                  value: _sendMoneyController.sendToUserList[_sendMoneyController.selectedToIndex.value], // Set the default selection
                  onChanged: (newValue) {
                    setState(() {
                      // Update the selected value
                      _sendMoneyController.toSelectedUserItem(newValue);
                    });
                  },
                  items: _sendMoneyController.sendToUserList.map((classCategoryValue) {
                    return DropdownMenuItem(
                      value: classCategoryValue,
                      child: Text(classCategoryValue.toString(),
                        style: TextStylesConstants.textStyleAppColor_15,
                        textAlign: TextAlign.start,
                      ),);
                  }).toList(),
                ),
              ),
            ),
          ),)
        ],
      ),
    );
  }

  Widget _amountView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(StringConstants.AMOUNT_,
            style: TextStylesConstants.textStyleBoldAppColor_16,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 5.0,),
          TextFormField(
            keyboardAppearance: Brightness.light,
            cursorColor: MindMapColors.colorApp,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyInputFormatter(),
            ],
            autocorrect: false,
            textInputAction: TextInputAction.next,
            style: TextStylesConstants.textStyleBoldAppColor_28,
            decoration: decorationAmount(StringConstants.AMOUNT_HINT),
            controller: _sendMoneyController.amountTextController,
          ),
        ],
      ),
    );
  }

  Widget _sendButtonAction(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          children: [
            Obx(() => !_sendMoneyController.isButtonDisabled.value ? CustomButton(
                label: StringConstants.SEND_MONEY,
                onPressed: () {
                  // Hide the keyboard
                  FocusScope.of(context).unfocus();
                  _sendMoneyController.checkValidation();
                },
                colorName: MindMapColors.buttonColor, widthSize: 240
            ) : CustomDisableButton(
              label: StringConstants.SEND_MONEY,
              onPressed: () {
                // Hide the keyboard
                FocusScope.of(context).unfocus();
              },
              colorName: MindMapColors.disableButton, widthSize: 240,
            ),
            ),
          ],
        ),
      ),
    );
  }



  decorationAmount(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 10),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorWhite,),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorWhite,),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorWhite,),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0,),),
        borderSide: BorderSide(color: MindMapColors.colorWhite),
      ),
      hintText: hint,
      hintStyle: TextStylesConstants.textStyleBoldAppColor_26,
      fillColor: MindMapColors.colorWhite,
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
