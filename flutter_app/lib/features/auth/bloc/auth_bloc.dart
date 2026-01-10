import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    } catch (e) {
      emit(AuthError(e.toString()));
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
          currentLevel: event.currentLevel,
        ),
      );
      
      // Auto-login after registration
      final tokenResponse = await _apiService.login(
        UserLogin(email: event.email, password: event.password),
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', tokenResponse.accessToken);
      
      emit(AuthAuthenticated(profile));
    } catch (e) {
      emit(AuthError(e.toString()));
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token != null) {
      try {
        final profile = await _apiService.getProfile();
        emit(AuthAuthenticated(profile));
      } catch (e) {
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
