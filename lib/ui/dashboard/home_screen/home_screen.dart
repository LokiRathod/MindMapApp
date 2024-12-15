import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/home_screen/home_controller.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mindmap_app/utils/all_constants/text_styles_constants.dart';
import 'package:mindmap_app/utils/all_constants/mindmap_colors.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_app_bar_action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext? myContext;
  final HomeController _homeController = Get.put(HomeController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MindMapColors.colorPrimary,
      appBar: CustomAppBarWithAction(
        title: StringConstants.DASHBOARD,
        color: MindMapColors.colorApp,
        onBackPressed: () {},
        onPressed: () {
          _homeController.commonFunctions.logoutCall();
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _walletBalanceWidget(context),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
            child: _buttonsWidget(context),
          )
        ],
      ),
    );
  }

  Widget _walletBalanceWidget(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: MindMapColors.astrich, // Card color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text('\₱ ${(_homeController.balanceVisible.value) ? "***.**" : _homeController.balance.value.toPrecision(2)}',
                    style: TextStylesConstants.textStyleBoldWhite_24,),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _homeController.balanceVisible.value = !_homeController.balanceVisible.value;
                    },
                      child: Icon((_homeController.balanceVisible.value) ? Icons.visibility_off :  Icons.visibility, color: Colors.white, size: 24,)),
                ],
              ),
              // Card Number
              Text(
                StringConstants.ACCOUNT_NUMBER,
                style: TextStylesConstants.textStyleBoldWhite_16,
              ),
              // Bottom Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_homeController.username.value, style: TextStylesConstants.textStyleBoldWhite_16,),
                  Text(StringConstants.ACCOUNT_DATA, style: TextStylesConstants.textStyleBoldWhite_16,),
                ],
              ),
            ],
          ),
        ),
      );
  }



  Widget _buttonsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {_homeController.appNavigation.goToSendMoneyScreen();},
            child: buttonViewWidget(StringConstants.SEND)),
        ),
        Expanded(flex: 5, child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {_homeController.appNavigation.goToTransactionScreen();},
            child: buttonViewWidget(StringConstants.ALL_TRANSACTIONS)),
        ),
      ],
    );
  }

  Widget buttonViewWidget(title) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: MindMapColors.tutorialTextShadowColor, // Card color
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.maps_home_work, // Placeholder for card logo
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(title, style: TextStylesConstants.textStyleBoldWhite_16,
                  ),
                ],
              ),
            ),
          ),
        );
  }

}
