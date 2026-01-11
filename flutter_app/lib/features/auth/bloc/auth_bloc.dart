import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../../core/di/injection.dart';
import '../../../core/models/user.dart';
import '../../../core/network/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService = getIt<ApiService>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final tokenResponse = await _apiService.login(
        UserLogin(email: event.email, password: event.password),
      );
      
      // Save token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', tokenResponse.accessToken);
      
      // Get user profile
      final profile = await _apiService.getProfile();
      
      emit(AuthAuthenticated(profile));
    } on DioException catch (e) {
      String errorMessage = _handleDioError(e);
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final profile = await _apiService.register(
        UserRegister(
          email: event.email,
          username: event.username,
          password: event.password,
        ),
      );
      
      // Auto-login after registration
      final tokenResponse = await _apiService.login(
        UserLogin(email: event.email, password: event.password),
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', tokenResponse.accessToken);
      
      emit(AuthAuthenticated(profile));
    } on DioException catch (e) {
      String errorMessage = _handleDioError(e);
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _apiService.logout();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      
      if (token != null) {
        try {
          final profile = await _apiService.getProfile();
          emit(AuthAuthenticated(profile));
        } catch (e) {
          // Token invalid or API error - clear token and go to login
          await prefs.remove('auth_token');
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      // If there's any error (e.g., API not available), go to login
      emit(AuthUnauthenticated());
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection and try again.';
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['detail'] ?? error.response?.data?['message'];
        
        if (statusCode == 401) {
          return 'Invalid email or password. Please try again.';
        } else if (statusCode == 400) {
          return message ?? 'Invalid request. Please check your input.';
        } else if (statusCode == 409) {
          return 'This email or username is already taken. Please use a different one.';
        } else if (statusCode == 422) {
          return message ?? 'Validation error. Please check your input.';
        } else if (statusCode != null && statusCode >= 500) {
          return 'Server error. Please try again later.';
        } else {
          return message ?? 'An error occurred. Please try again.';
        }
      
      case DioExceptionType.cancel:
        return 'Request cancelled.';
      
      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Please check your internet connection.';
      
      case DioExceptionType.badCertificate:
        return 'Certificate error. Please try again later.';
      
      case DioExceptionType.unknown:
      default:
        if (error.message?.contains('SocketException') == true ||
            error.message?.contains('Network is unreachable') == true) {
          return 'No internet connection. Please check your network settings.';
        }
        return 'Unable to connect to the server. Please check your internet connection and try again.';
    }
  }
}
