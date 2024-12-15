import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/home_screen/home_controller.dart';
import 'package:mindmap_app/ui/dashboard/home_screen/home_screen.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mockito/mockito.dart';

// Extend Mock with the actual controller
class MockHomeController extends Mock implements HomeController {}

void main() {
  late MockHomeController mockHomeController;

  setUp(() {
    mockHomeController = MockHomeController();
    Get.put<HomeController>(mockHomeController); // Inject mock controller
  });

  tearDown(() {
    Get.reset();
  });

  group('HomeScreen UI Tests', () {
    testWidgets('HomeScreen displays wallet balance widget correctly', (WidgetTester tester) async {
      // Arrange
      when(mockHomeController.balanceVisible.value).thenReturn(false);
      when(mockHomeController.balance.value).thenReturn(1000.0.obs as double);

      // Act
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeScreen(),
        ),
      );

      // Assert
      expect(find.text(StringConstants.DASHBOARD), findsOneWidget); // AppBar title
      expect(find.text('\₱ 1000.00'), findsOneWidget); // Wallet balance
      expect(find.text(StringConstants.ACCOUNT_NUMBER), findsOneWidget); // Account number label
    });

    testWidgets('Tapping on visibility icon toggles balance visibility', (WidgetTester tester) async {
      // Arrange
      when(mockHomeController.balanceVisible.value).thenReturn(true);
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeScreen(),
        ),
      );

      // Act
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      // Assert
      verify(mockHomeController.balanceVisible.value = false).called(1);
    });

    testWidgets('HomeScreen shows buttons for send money and transactions', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const HomeScreen(),
        ),
      );

      // Assert
      expect(find.text(StringConstants.SEND), findsOneWidget);
      expect(find.text(StringConstants.ALL_TRANSACTIONS), findsOneWidget);
    });

    testWidgets('Tapping Send Money button navigates to send money screen', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.tap(find.text(StringConstants.SEND));
      await tester.pump();

      // Assert
      verify(mockHomeController.appNavigation.goToSendMoneyScreen()).called(1);
    });

    testWidgets('Tapping All Transactions button navigates to transactions screen', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const HomeScreen(),
        ),
      );

      await tester.tap(find.text(StringConstants.ALL_TRANSACTIONS));
      await tester.pump();

      // Assert
      verify(mockHomeController.appNavigation.goToTransactionScreen()).called(1);
    });

    testWidgets('Logout function is triggered on AppBar action tap', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.tap(find.byIcon(Icons.logout)); // Replace with actual icon if different
      await tester.pump();

      // Assert
      verify(mockHomeController.commonFunctions.logoutCall()).called(1);
    });
  });
}
