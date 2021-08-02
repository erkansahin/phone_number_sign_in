import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/i_auth_service.dart';

import '../../../injection.dart';

part 'phone_number_sign_in_cubit.freezed.dart';
part 'phone_number_sign_in_state.dart';

@injectable
class PhoneNumberSignInCubit extends Cubit<PhoneNumberSignInState> {
  static const int smsCodeLength = 6;
  late final IAuthService _authService;

  StreamSubscription<Either<AuthFailure, String>>?
      _phoneNumberSignInSubscription;

  final Duration verificationCodeTimeout = const Duration(seconds: 60);
  PhoneNumberSignInCubit() : super(PhoneNumberSignInState.initial()) {
    _authService = getIt<IAuthService>();
  }

  @override
  Future<void> close() async {
    await _phoneNumberSignInSubscription?.cancel();

    return super.close();
  }

  void smsCodeChanged({
    required String smsCode,
  }) {
    emit(state.copyWith(smsCode: smsCode));
  }

  void phoneNumberChanged({
    required String phoneNumber,
  }) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void reset() {
    emit(
      state.copyWith(
        failureOption: none(),
        verificationIdOption: none(),
        isInProgress: false,
      ),
    );
  }

  void signInWithPhoneNumber() {
    emit(state.copyWith(isInProgress: true, failureOption: none()));

    _phoneNumberSignInSubscription = _authService
        .signInWithPhoneNumber(
            phoneNumber: state.phoneNumber, timeout: verificationCodeTimeout)
        .listen(
          (Either<AuthFailure, String> failureOrVerificationId) =>
              failureOrVerificationId.fold(
            (AuthFailure failure) {
              //This is the part where we receive failures like 'invalidPhoneNumber', 'smsTimeout' etc.
              emit(
                state.copyWith(
                    failureOption: some(failure), isInProgress: false),
              );
            },
            (String verificationId) {
              // Catch this in Bloc Listener and take the user to SMS code entry page.
              emit(
                state.copyWith(
                  verificationIdOption: some(verificationId),
                  isInProgress: false,
                ),
              );
            },
          ),
        );
  }

  void verifySmsCode() {
    state.verificationIdOption.fold(
      () {
        //Verification id does not exist. This should not happen.
      },
      (String verificationId) async {
        emit(
          state.copyWith(
            isInProgress: true,
            failureOption: none(),
          ),
        );
        final Either<AuthFailure, Unit> failureOrSuccess =
            await _authService.verifySmsCode(
                smsCode: state.smsCode, verificationId: verificationId);
        failureOrSuccess.fold(
          (AuthFailure failure) {
            emit(
              state.copyWith(failureOption: some(failure), isInProgress: false),
            );
          },
          (_) {
            emit(state.copyWith(isInProgress: false));
            // Verification completed successfully case.
            // Bloc Listener in the UI should listen to Auth Listener State and if user is authenticated and not anonymous, we should take them to Registration page or Feed Page.
          },
        );
      },
    );
  }
}
