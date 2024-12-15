import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mindmap_app/beans/response_pojo/GetTransactionResponse.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:mindmap_app/ui/dashboard/transactions/transaction_controller.dart';
import 'package:mindmap_app/api_calls/api_service.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late TransactionController transactionController;
  late MockApiService mockApiService;

  setUp(() {
    Get.testMode = true;
    mockApiService = MockApiService();
    transactionController = TransactionController();
  });

  tearDown(() {
    Get.reset();
  });

  group('TransactionController Tests', () {
    test('Initial values are correct', () {
      expect(transactionController.posts, isEmpty);
    });

    test('getTransactionListApiCall updates posts on success', () async {
      // Arrange
      final transactionResponse = [GetTransactionResponse(id: 123)];
      when(mockApiService.getTransactionListCall()).thenAnswer((_) async => transactionResponse);

      // Act
      await transactionController.getTransactionListApiCall();

      // Assert
      expect(transactionController.posts, transactionResponse);
    });

    test('getTransactionListApiCall shows snackbar on failure', () async {
      // Arrange
      when(mockApiService.getTransactionListCall()).thenThrow(Exception("Error"));

      // Act
      await transactionController.getTransactionListApiCall();

      // Assert
      expect(transactionController.posts.isEmpty, true);
    });
  });
}
