// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_cubit.dart' as _i3;
import 'application/auth/phone_number_sign_in/phone_number_sign_in_cubit.dart'
    as _i7;
import 'domain/auth/i_auth_service.dart' as _i5;
import 'infrastructure/auth/firebase_auth_service.dart' as _i6;
import 'infrastructure/core/injectable_module.dart' as _i9;
import 'presentation/routes/router.gr.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.lazySingleton<_i3.AuthCubit>(() => _i3.AuthCubit());
  gh.lazySingleton<_i4.FirebaseAuth>(() => injectableModule.firebaseAuth);
  gh.lazySingleton<_i5.IAuthService>(
      () => _i6.FirebaseAuthService(get<_i4.FirebaseAuth>()));
  gh.factory<_i7.PhoneNumberSignInCubit>(() => _i7.PhoneNumberSignInCubit());
  gh.singleton<_i8.AppRouter>(injectableModule.appRouter);
  return get;
}

class _$InjectableModule extends _i9.InjectableModule {}
