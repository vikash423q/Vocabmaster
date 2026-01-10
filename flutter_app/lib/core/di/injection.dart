import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/api_service.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Network
  final apiClient = ApiClient();
  getIt.registerLazySingleton<Dio>(() => apiClient.dio);
  getIt.registerLazySingleton<ApiService>(() => ApiService(apiClient.dio));

  // Services will be registered here
  // getIt.registerLazySingleton<AuthService>(() => AuthService(getIt()));
  // getIt.registerLazySingleton<WordService>(() => WordService(getIt()));
  // getIt.registerLazySingleton<AIService>(() => AIService(getIt()));
}
