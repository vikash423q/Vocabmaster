import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add auth token if available
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // Ignore SharedPreferences errors
      print('Error getting auth token: $e');
    }
    
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Log errors for debugging
    print('API Error: ${err.message}');
    print('URL: ${err.requestOptions.uri}');
    print('Method: ${err.requestOptions.method}');
    if (err.requestOptions.data != null) {
      print('Request Data: ${err.requestOptions.data}');
    }
    if (err.response != null) {
      print('Status: ${err.response?.statusCode}');
      print('Response: ${err.response?.data}');
    } else {
      print('No response received - network error');
      print('Error type: ${err.type}');
    }
    
    // Handle errors globally
    if (err.response?.statusCode == 401) {
      // Handle unauthorized - clear token and redirect to login
      // This would be handled by a global error handler
    }
    
    return handler.next(err);
  }
}
