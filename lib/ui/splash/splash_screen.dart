import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/splash/splash_controller.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late final SplashController _splashController = Get.put(SplashController());

 @override
  void initState() {
   _splashController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MindMapColors.buttonColor,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(StringConstants.APP_NAME, style: TextStylesConstants.textStyleAppColor_28),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }


}
