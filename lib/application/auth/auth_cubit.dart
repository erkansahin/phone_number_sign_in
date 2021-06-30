import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_user_model.dart';
import '../../domain/auth/i_auth_service.dart';
import '../../injection.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  late final IAuthService _authService;

  ///The stream subscription for listening to the auth state changes
  late StreamSubscription<AuthUserModel>? _authUserSubscription;
  AuthCubit() : super(AuthState.empty()) {
    _authService = getIt<IAuthService>();
    _authUserSubscription =
        _authService.authStateChanges.listen(_listenAuthStateChangesStream);
  }
  @override
  Future<void> close() async {
    await _authUserSubscription?.cancel();
    super.close();
  }

  Future<void> _listenAuthStateChangesStream(AuthUserModel authUser) async {
    emit(
      state.copyWith(
        userModel: authUser,
        isUserCheckedFromAuthService: true,
      ),
    );
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
