import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/beans/response_pojo/GetTransactionResponse.dart';
import 'package:mindmap_app/ui/dashboard/transactions/transaction_controller.dart';
import 'package:mindmap_app/ui/dashboard/transactions/transaction_screen.dart';
import 'package:mockito/mockito.dart';

class MockTransactionController extends Mock implements TransactionController {}

void main() {
  late MockTransactionController mockTransactionController;

  setUp(() {
    mockTransactionController = MockTransactionController();
    Get.put<TransactionController>(mockTransactionController);
  });

  tearDown(() {
    Get.reset();
  });

  group('TransactionScreen UI Tests', () {
    testWidgets('TransactionScreen displays transactions list', (WidgetTester tester) async {
      // Arrange
      when(mockTransactionController.posts).thenReturn([
        GetTransactionResponse(id: 1),
        GetTransactionResponse(id: 2)
      ].obs);

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const TransactionScreen(),
        ),
      );

      // Assert
      expect(find.text("Transactions"), findsOneWidget);
      expect(find.textContaining("1"), findsWidgets);
      expect(find.textContaining("2"), findsWidgets);
    });

    testWidgets('TransactionScreen shows bottom sheet on item tap', (WidgetTester tester) async {
      // Arrange
      when(mockTransactionController.posts).thenReturn([
        GetTransactionResponse(id: 123),
      ].obs);

      // Act
      await tester.pumpWidget(
        GetMaterialApp(
          home: const TransactionScreen(),
        ),
      );
      await tester.tap(find.textContaining("123"));
      await tester.pump();

      // Assert
      expect(find.textContaining("Transaction Successfully"), findsOneWidget);
      expect(find.textContaining("with amount  \$ 123"), findsOneWidget);
    });

    testWidgets('Logout function is triggered on AppBar action tap', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const GetMaterialApp(
          home: TransactionScreen(),
        ),
      );

      await tester.tap(find.byIcon(Icons.logout)); // Replace with actual logout icon if different
      await tester.pump();

      // Assert
      verify(mockTransactionController.commonFunctions.logoutCall()).called(1);
    });
  });
}
