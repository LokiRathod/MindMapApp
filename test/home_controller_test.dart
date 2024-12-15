import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mindmap_app/ui/dashboard/home_screen/home_controller.dart';
import 'package:mindmap_app/utils/all_constants/store_data_constants.dart';
import 'package:mindmap_app/utils/storage_service.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  late HomeController homeController;
  late MockStorageService mockStorageService;
  late GetStorage mockBox;

  setUp(() {
    mockStorageService = MockStorageService();
    mockBox = GetStorage();
    homeController = HomeController();
    homeController.storageService = mockStorageService; // Assign mock storage
    homeController.box = mockBox; // Inject mock GetStorage
  });

  tearDown(() {
    Get.reset();
  });

  group('HomeController Tests', () {
    test('onInit calls checkValidation and updates username', () {
      // Arrange
      when(mockStorageService.readString(StoreDataConstants.USER_NAME))
          .thenReturn("TestUser");

      // Act
      homeController.onInit();

      // Assert
      expect(homeController.username.value, "TestUser");
      verify(mockStorageService.readString(StoreDataConstants.USER_NAME)).called(1);
    });

    test('checkValidation updates username from storage', () {
      // Arrange
      when(mockStorageService.readString(StoreDataConstants.USER_NAME))
          .thenReturn("MockUser");

      // Act
      homeController.checkValidation();

      // Assert
      expect(homeController.username.value, "MockUser");
      verify(mockStorageService.readString(StoreDataConstants.USER_NAME)).called(1);
    });

    test('showBalance toggles correctly', () {
      // Arrange
      expect(homeController.showBalance.value, true);

      // Act
      homeController.showBalance.value = false;

      // Assert
      expect(homeController.showBalance.value, false);
    });

    test('balanceVisible toggles correctly', () {
      // Arrange
      expect(homeController.balanceVisible.value, true);

      // Act
      homeController.balanceVisible.value = false;

      // Assert
      expect(homeController.balanceVisible.value, false);
    });

    test('balance has a default value and can be updated', () {
      // Assert default balance
      expect(homeController.balance.value, 500.00);

      // Act
      homeController.balance.value = 1000.00;

      // Assert updated balance
      expect(homeController.balance.value, 1000.00);
    });
  });
}
