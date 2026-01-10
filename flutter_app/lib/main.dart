import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';
import 'core/di/injection.dart' as di;
import 'features/auth/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  
  // Initialize dependency injection
  await di.init();
  
  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(CheckAuthStatus()),
      child: const VocabMasterApp(),
    ),
  );
}
