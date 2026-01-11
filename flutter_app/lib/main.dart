import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'app/app.dart';
import 'core/di/injection.dart' as di;
import 'features/auth/bloc/auth_bloc.dart';
import 'storage/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize HydratedBloc storage
  // On web, path_provider doesn't work, so we skip HydratedBloc persistence
  // The app will work but state won't persist across page refreshes
  if (!kIsWeb) {
    try {
      HydratedBloc.storage = await initStorage();
    } catch (e) {
      // If storage initialization fails, app will still work
      print('Warning: Could not initialize HydratedBloc storage: $e');
    }
  }
  // On web, we skip HydratedBloc - state won't persist but app works
  
  // Initialize dependency injection
  await di.init();
  
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(CheckAuthStatus()),
      child: const VocabMasterApp(),
    ),
  );
}
