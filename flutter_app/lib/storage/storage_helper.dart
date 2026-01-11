import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Conditional import for path_provider (mobile only)
import 'storage_helper_stub.dart'
    if (dart.library.io) 'storage_helper_mobile.dart'
    if (dart.library.html) 'storage_helper_web.dart';

Future<HydratedStorage> initStorage() async {
  if (kIsWeb) {
    // Web: Use web storage helper
    return await initWebStorage();
  } else {
    // Mobile: Use path_provider
    return await initMobileStorage();
  }
}
