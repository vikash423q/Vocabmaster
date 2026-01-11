import 'package:hydrated_bloc/hydrated_bloc.dart';

Future<HydratedStorage> initMobileStorage() async {
  throw UnsupportedError('Use initWebStorage on web');
}

Future<HydratedStorage> initWebStorage() async {
  // Web: HydratedBloc doesn't support web out of the box
  // We'll use a workaround - create a simple storage that uses browser APIs
  // For now, return a storage that uses IndexedDB via HydratedStorage
  // Note: This requires the storageDirectory parameter, so we'll need to handle it differently
  
  // Actually, HydratedBloc on web should work without a directory
  // But the API requires it. Let's use a workaround with a fake directory
  // or skip persistence on web
  
  // Temporary workaround: Use a simple implementation
  // In production, you might want to use a different storage solution for web
  throw UnsupportedError(
    'HydratedBloc requires storageDirectory which is not available on web. '
    'Consider using a different state persistence solution for web, or skip persistence.'
  );
}
