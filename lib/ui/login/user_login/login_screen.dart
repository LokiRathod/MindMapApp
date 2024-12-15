import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/login/user_login/login_controller.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_button.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';



class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final LogInController _logInController = Get.put(LogInController());
  var passwordVisible = true;


  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor:MindMapColors.colorWhite,
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 120,),
                  // Logo or App Name
                  logoIcon(),
                  const SizedBox(height: 50.0,),

                  // Login Form
                  _logInForm(),
                  const SizedBox(height: 50.0,),

                  // Login Button
                  _logInButtonAction(context)
                ],
              ),
            ),
          ),
    );
  }


  Widget logoIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 180,
          child: Center(
            child: Text(StringConstants.APP_NAME, style: TextStylesConstants.textStyleColor_28),
          ),
        ),
      ],
    );
  }

  Widget _logInForm() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      autovalidateMode: AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SizedBox(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Email ID
              TextFormField(
                keyboardAppearance: Brightness.light,
                cursorColor: MindMapColors.colorApp,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                style: TextStylesConstants.textStyleBoldAppColor_15,
                decoration: decoration(StringConstants.USERNAME),
                controller: _logInController.userNameTextController,
                validator: (value) { return _logInController.dataMapService.validateUserName(value!); },
              ),

              const SizedBox(height: 20,),

              // Password
              TextFormField(
                keyboardAppearance: Brightness.light,
                cursorColor: MindMapColors.colorApp,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autocorrect: false,
                style: TextStylesConstants.textStyleBoldAppColor_15,
                decoration: _logInController.passwordText.value
                    ? decorationPassword(StringConstants.PASSWORD_HINT)
                    : decorationPassword(StringConstants.PASSWORD),
                obscureText: passwordVisible,
                controller: _logInController.passwordTextController,
                validator: (value) { return _logInController.dataMapService.validatePassword(value!); },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logInButtonAction(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: SizedBox(
        width: screenWidth,
        child: Column(
          children: [
            Obx(() => !_logInController.isLogInButtonDisabled.value ? CustomButton(
                label: StringConstants.LOGIN,
                onPressed: () {
                  // Hide the keyboard
                  FocusScope.of(context).unfocus();
                  _logInController.checkValidation();
                },
                colorName: MindMapColors.buttonColor, widthSize: 240
              ) : CustomDisableButton(
              label: StringConstants.LOGIN,
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

  decoration(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(top: 2, left: 24),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0,),),
        borderSide: BorderSide(color: MindMapColors.colorBlack10),
      ),
      hintText: hint,
      hintStyle: TextStylesConstants.textStyleBoldHint_15,
      filled: true,
      fillColor: MindMapColors.colorBlack10,
    );
  }

  decorationPassword(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.only(top: 15, left: 24, bottom: 0),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          borderSide: BorderSide(color: MindMapColors.colorBlack10)),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
        borderSide: BorderSide(color: MindMapColors.colorBlack10,),
      ),
      hintText: hint,
      hintStyle: TextStylesConstants.textStyleBoldHint_15,
      filled: true,
      fillColor: MindMapColors.colorBlack10,
      suffixIcon: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
        child: Icon(
          passwordVisible ? Icons.visibility_off : Icons.visibility,
        ),
      ),

    );
  }

  @override
  void dispose() {
    super.dispose();
  }


}
