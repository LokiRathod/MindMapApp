import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/ui/login/user_login/login_controller.dart';
import 'package:mindmap_app/ui/login/user_login/login_screen.dart';
import 'package:mindmap_app/utils/custom_widgets/custom_button.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'mocks.mocks.dart';

class MockPathProvider extends PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async {
    final tempDir = Directory.systemTemp.createTempSync();
    return tempDir.path;
  }
}

void main() {
  late LogInController logInController;
  late MockAppNavigation mockAppNavigation;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    PathProviderPlatform.instance = MockPathProvider();

    final docsPath = await PathProviderPlatform.instance.getApplicationDocumentsPath();
    if (docsPath == null) {
      throw Exception('Failed to get application documents path.');
    }
    await GetStorage.init(
      path.join(docsPath, 'get_storage'),
    );


    mockAppNavigation = MockAppNavigation();
    logInController = LogInController();
    logInController.appNavigation = mockAppNavigation;
    Get.put(logInController);
  });

  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const LogInScreen(),
      ),
    );

    // Adjust to match widget properties
    expect(find.textContaining('MindMap'), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.widgetWithText(CustomButton, 'Login'), findsOneWidget);
  });

  testWidgets('Login button is initially disabled and becomes enabled after valid input', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const LogInScreen(),
      ),
    );

    final loginButton = find.widgetWithText(CustomButton, 'Login');
    expect(loginButton, findsOneWidget);
    expect(tester.widget<CustomButton>(loginButton).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).first, 'testuser');
    await tester.enterText(find.byType(TextFormField).last, 'password123');
    await tester.pump();

    expect(tester.widget<CustomButton>(loginButton).onPressed, isNotNull);
  });

  testWidgets('Password visibility toggle works', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const LogInScreen(),
      ),
    );

    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, 'password123');
    await tester.pump();

    expect(find.text('password123'), findsNothing);

    final visibilityToggle = find.byIcon(Icons.visibility_off);
    await tester.tap(visibilityToggle);
    await tester.pump();

    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('Login button navigates to home screen on valid input', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const LogInScreen(),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, 'testuser');
    await tester.enterText(find.byType(TextFormField).last, 'password123');
    await tester.pump();

    final loginButton = find.widgetWithText(CustomButton, 'Login');
    await tester.tap(loginButton);
    await tester.pump();

    verify(mockAppNavigation.goToHomeScreen()).called(1);
  });
}
