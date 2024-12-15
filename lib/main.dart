import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/ui/splash/splash_screen.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/network_connection.dart';


void main() async {
  await GetStorage.init();
  runApp(const MindMapApp());

  // Restrict the Application Orientation to Portrait Up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // Color for Android
  ));

  // Instantiate the Singleton Network Connection Object
  NetworkConnection();
  NetworkConnection().initialise();

}


class MindMapApp extends StatelessWidget {
  const MindMapApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConstants.APP_NAME,
      theme: ThemeData(
        primaryColor: MindMapColors.colorBlack100,
        primaryColorDark: MindMapColors.colorBlack100,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
