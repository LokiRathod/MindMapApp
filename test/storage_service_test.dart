import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:mindmap_app/utils/storage_service.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'mocks.mocks.dart';

// Mock PathProvider
class MockPathProvider extends PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() async {
    final tempDir = Directory.systemTemp.createTempSync();
    return tempDir.path;
  }
}

void main() async {
  late StorageService storageService;
  late MockGetStorage mockGetStorage;

  setUp(() async {
    // Ensure Flutter bindings are initialized
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock PathProvider to avoid platform-specific calls
    PathProviderPlatform.instance = MockPathProvider();

    // Initialize GetStorage with a temporary in-memory directory
    await GetStorage.init(
        path.join((await PathProviderPlatform.instance.getApplicationDocumentsPath())!, 'get_storage')
    );

    // Inject mocked GetStorage
    mockGetStorage = MockGetStorage();
    storageService = StorageService();
    storageService.storage = mockGetStorage;
  });

  group('StorageService Tests', () {
    test('saveString writes a string value to storage', () {
      const key = 'testKey';
      const value = 'testValue';

      // Act
      storageService.saveString(key, value);

      // Assert
      verify(mockGetStorage.write(key, value)).called(1);
    });

    test('readString reads a string value from storage', () {
      const key = 'testKey';
      const value = 'testValue';

      // Arrange
      when(mockGetStorage.read(key)).thenReturn(value);

      // Act
      final result = storageService.readString(key);

      // Assert
      expect(result, value);
      verify(mockGetStorage.read(key)).called(1);
    });

    test('saveBool writes a boolean value to storage', () {
      const key = 'testBoolKey';
      const value = true;

      // Act
      storageService.saveBool(key, value);

      // Assert
      verify(mockGetStorage.write(key, value)).called(1);
    });

    test('readBool reads a boolean value from storage', () {
      const key = 'testBoolKey';
      const value = true;

      // Arrange
      when(mockGetStorage.read(key)).thenReturn(value);

      // Act
      final result = storageService.readBool(key);

      // Assert
      expect(result, value);
      verify(mockGetStorage.read(key)).called(1);
    });

    test('saveInt writes an integer value to storage', () {
      const key = 'testIntKey';
      const value = 123;

      // Act
      storageService.saveInt(key, value);

      // Assert
      verify(mockGetStorage.write(key, value)).called(1);
    });

    test('readInt reads an integer value from storage', () {
      const key = 'testIntKey';
      const value = 123;

      // Arrange
      when(mockGetStorage.read(key)).thenReturn(value);

      // Act
      final result = storageService.readInt(key);

      // Assert
      expect(result, value);
      verify(mockGetStorage.read(key)).called(1);
    });
  });
}
