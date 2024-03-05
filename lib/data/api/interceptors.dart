import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // Hide method count
      errorMethodCount: 5, // Show only 5 lines of stack trace for errors
      lineLength: 80,
      colors: true, // Enable colors
      printEmojis: true, // Enable emojis
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Check for internet connectivity before making the request
      var connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        // Handle the case when there is no internet connection
        logger.w('No internet connection');
        Fluttertoast.showToast(
          msg: 'No internet connection',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return handler.reject(DioException(
          requestOptions: options,
          error: 'No internet connection',
        ));
      }

      logger.i('Request: ${options.method} - ${options.uri}');
    } catch (e) {
      logger.e('Error logging request details: $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      logger.i('Response: ${response.statusCode}');
    } catch (e) {
      logger.e('Error handling response: $e');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      logger.e('Error: ${err.message}');
      if (err.response != null) {
        logger.e('Response: ${err.response!.statusCode}');
      }
    } catch (e) {
      logger.e('Error handling error: $e');
    }
    super.onError(err, handler);
  }
}

class RetryInterceptor extends Interceptor {
  int maxRetries = 3;
  int currentRetry = 0;

  @override
  Future onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Attach current retry count to the extra field
    options.extra['currentRetry'] = currentRetry;
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    // Implement retry logic based on response status, if needed
    if (response.statusCode == 503 && currentRetry < maxRetries) {
      currentRetry++;
      handler.next(response);
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // Implement retry logic based on error, if needed
    if (err.type == DioExceptionType.connectionTimeout &&
        currentRetry < maxRetries) {
      currentRetry++;
      handler.next(err);
    }
    return super.onError(err, handler);
  }
}
