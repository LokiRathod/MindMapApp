import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/ui/dashboard/send_money/send_money_controller.dart';
import 'package:mindmap_app/ui/dashboard/send_money/send_money_screen.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'package:mockito/mockito.dart';

class MockSendMoneyController extends Mock implements SendMoneyController {}

void main() {
  late MockSendMoneyController mockSendMoneyController;

  setUp(() {
    mockSendMoneyController = MockSendMoneyController();
    Get.put<SendMoneyController>(mockSendMoneyController);
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('SendMoneyScreen displays all widgets correctly', (WidgetTester tester) async {
    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        home: const SendMoneyScreen(),
      ),
    );

    // Assert
    expect(find.text(StringConstants.SEND_TO_), findsOneWidget);
    expect(find.text(StringConstants.AMOUNT_), findsOneWidget);
    expect(find.text(StringConstants.SEND_MONEY), findsOneWidget);
  });

  testWidgets('Tapping Send Money triggers validation and API call', (WidgetTester tester) async {
    when(mockSendMoneyController.isButtonDisabled.value).thenReturn(false);
    when(mockSendMoneyController.checkValidation()).thenAnswer((_) async {});

    await tester.pumpWidget(
      GetMaterialApp(
        home: const SendMoneyScreen(),
      ),
    );

    await tester.tap(find.text(StringConstants.SEND_MONEY));
    await tester.pump();

    verify(mockSendMoneyController.checkValidation()).called(1);
  });

  testWidgets('Dropdown menu updates selected item', (WidgetTester tester) async {
    when(mockSendMoneyController.sendToUserList)
        .thenReturn(['User1', 'User2', 'User3'].obs);
    when(mockSendMoneyController.selectedToItem.value).thenReturn('User1');

    await tester.pumpWidget(
      const GetMaterialApp(
        home: SendMoneyScreen(),
      ),
    );

    // Tap on the dropdown
    await tester.tap(find.byType(DropdownButton));
    await tester.pump();

    // Select an item
    await tester.tap(find.text('User2').last);
    await tester.pump();

    verify(mockSendMoneyController.toSelectedUserItem('User2')).called(1);
  });

  testWidgets('Amount text field updates the controller value', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: SendMoneyScreen(),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '500');
    await tester.pump();

    expect(mockSendMoneyController.amountTextController.text, '500');
  });
}
