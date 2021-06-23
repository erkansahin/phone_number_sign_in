// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/auth/i_auth_service.dart' as _i3;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i4;
import 'infrastructure/core/injectable_module.dart' as _i7;
import 'presentation/routes/router.gr.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.IAuthService>(
      () => _i4.FirebaseAuthService(get<_i5.FirebaseAuth>()));
  gh.singleton<_i6.AppRouter>(injectableModule.appRouter);
  return get;
}

class _$InjectableModule extends _i7.InjectableModule {}
