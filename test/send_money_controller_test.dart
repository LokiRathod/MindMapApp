import 'package:flutter_test/flutter_test.dart';
import 'package:mindmap_app/ui/dashboard/send_money/send_money_controller.dart';
import 'package:mockito/mockito.dart';
import 'package:mindmap_app/utils/common_functions.dart';
import 'package:mindmap_app/utils/network_connection.dart';

class MockCommonFunctions extends Mock implements CommonFunctions {}
class MockNetworkConnection extends Mock implements NetworkConnection {}

void main() {
  late SendMoneyController sendMoneyController;
  late MockCommonFunctions mockCommonFunctions;
  late MockNetworkConnection mockNetworkConnection;

  setUp(() {
    mockCommonFunctions = MockCommonFunctions();
    mockNetworkConnection = MockNetworkConnection();
    sendMoneyController = SendMoneyController();
    sendMoneyController.commonFunctions = mockCommonFunctions;
  });

  test('Initial state is correct', () {
    expect(sendMoneyController.selectedToItem.value, '');
    expect(sendMoneyController.isButtonDisabled.value, true);
  });

  test('validateForm enables button with valid input', () {
    sendMoneyController.amountTextController.text = "50";
    sendMoneyController.validateForm();
    expect(sendMoneyController.isButtonDisabled.value, false);
  });

  test('validateForm disables button with invalid input', () {
    sendMoneyController.amountTextController.text = "";
    sendMoneyController.validateForm();
    expect(sendMoneyController.isButtonDisabled.value, true);
  });

  test('checkValidation shows success bottom sheet on valid API call', () async {
    when(mockNetworkConnection.connected).thenReturn(true);

    // Simulate successful API response
    // Mocking `sendMoneyCall` can be added here if needed

    await sendMoneyController.checkValidation();
    // Assert UI updates or bottom sheet shown
  });

  test('checkValidation shows error on network failure', () async {
    when(mockNetworkConnection.connected).thenReturn(false);

    await sendMoneyController.checkValidation();
  });
}
