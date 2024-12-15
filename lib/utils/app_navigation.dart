import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/home_screen/home_screen.dart';
import 'package:mindmap_app/ui/dashboard/send_money/send_money_screen.dart';
import 'package:mindmap_app/ui/dashboard/transactions/transaction_screen.dart';
import 'package:mindmap_app/ui/login/user_login/login_screen.dart';


class AppNavigation {

  goToLogInScreen() {
    Get.offAll(() => const LogInScreen());
  }
  goToHomeScreen() {
    Get.offAll(() => const HomeScreen());
  }
  goToSendMoneyScreen() {
    Get.to(() => const SendMoneyScreen());
  }
 goToTransactionScreen() {
    Get.to(() => const TransactionScreen());
  }

}