import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mindmap_app/beans/request_pojo/SendMoneyRequest.dart';
import 'package:mindmap_app/beans/response_pojo/GetTransactionResponse.dart';
import 'package:mindmap_app/utils/all_constants/end_points_constants.dart';
import 'package:retrofit/retrofit.dart';


part 'api_service.g.dart';

@RestApi(baseUrl: EndPointsConstants.BASE_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  final dio = Dio();

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return ApiService(dio);
  }


  // POST API
  @POST(EndPointsConstants.TRANSACTION_LIST)
  Future<GetTransactionResponse> sendMoneyCall(@Body() SendMoneyRequest request);

  @GET(EndPointsConstants.TRANSACTION_LIST)
  Future<List<GetTransactionResponse>> getTransactionListCall();


}


