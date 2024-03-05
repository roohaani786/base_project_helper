import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/models/todo/todo_model.dart';
import 'interceptors.dart';

part 'api_manager.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com") // Replace with your actual base URL
abstract class ApiManager {
  factory ApiManager(Dio dio, {String? baseUrl}) {
    // dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true));
    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(RetryInterceptor());
    return _ApiManager(dio, baseUrl: baseUrl);
  }

  @GET("/todos/1")
  Future<TodoModel> getTodo();
}

// class _ApiManager implements ApiManager {
//   final Dio _dio;
//   final String? _baseUrl;
//
//   _ApiManager(this._dio, {String? baseUrl}) : _baseUrl = baseUrl;
//
//   @override
//   Future<String> getExample() async {
//     Response<String> response = await _dio.get<String>("/example");
//     return response.data ?? "";
//   }
// }