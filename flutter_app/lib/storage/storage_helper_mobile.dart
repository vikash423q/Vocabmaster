import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<HydratedStorage> initMobileStorage() async {
  return await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
}

Future<HydratedStorage> initWebStorage() async {
  throw UnsupportedError('Use initMobileStorage on mobile');
}
