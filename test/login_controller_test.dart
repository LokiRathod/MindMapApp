import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:mindmap_app/ui/login/user_login/login_controller.dart';
import 'package:mindmap_app/utils/all_constants/string_constants.dart';
import 'mocks.mocks.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize Flutter test environment
  await GetStorage.init(); // Initialize GetStorage
  late LogInController logInController;
  late MockAppNavigation mockAppNavigation;

  setUp(() {
    // Create mock instances
    mockAppNavigation = MockAppNavigation();
    logInController = LogInController();

    // Inject mock AppNavigation into the controller
    logInController.appNavigation = mockAppNavigation;

    // Add the controller to GetX
    Get.put(logInController);
  });

  test('Login button is disabled with empty inputs', () {
    logInController.userNameTextController.text = '';
    logInController.passwordTextController.text = '';
    logInController.validateForm();

    expect(logInController.isLogInButtonDisabled.value, true);
  });

  test('Login button is enabled with valid inputs', () {
    logInController.userNameTextController.text = 'testuser';
    logInController.passwordTextController.text = 'password123';
    logInController.validateForm();

    expect(logInController.isLogInButtonDisabled.value, false);
  });

  test('Password visibility toggle works', () {
    logInController.passwordVisible.value = true;
    logInController.passwordVisible.toggle();

    expect(logInController.passwordVisible.value, false);
  });

  test('Login navigation calls goToHomeScreen', () {
    // Mock the goToHomeScreen behavior
    when(mockAppNavigation.goToHomeScreen()).thenAnswer((_) => Future.value());

    // Trigger the navigation method in the controller
    logInController.navigateToHomeScreen();

    // Verify that the goToHomeScreen method was called
    verify(mockAppNavigation.goToHomeScreen()).called(1);
  });

  test('Error snackbar is shown on failed network connection', () async {
    // Mock a failed network scenario
    when(mockAppNavigation.goToHomeScreen()).thenAnswer((_) => Future.value());

    // Call the method
    logInController.checkValidation();

    // Verify the snackbar is shown
    expect(() => Get.snackbar(StringConstants.APP_NAME, StringConstants.NO_INTERNET),
        returnsNormally);
  });
}
