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
  late IAuthService _authService;
  StreamSubscription<Option<Either<AuthFailure, String>>>?
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
      (Option<Either<AuthFailure, String>> smsEvent) {
        smsEvent.fold(
          () {
            //  emit(state.copyWith(isInProgress: false));
            // AUTO SIGN IN for newer android phones. We currently do not handle this case. All phone models are required to enter verification code.
            // This will never get triggered unless the relevant code snippet in the infrastructure is enabled.
          },
          (Either<AuthFailure, String> either) => either.fold(
            (AuthFailure failure) {
              //This is the part where we receive failures like 'invalidPhoneNumber', 'smsTimeout' etc.
              //If 'smsTimeout' failure is received, disable SMS entry widget and instead show, resend code button.
              //This method, can be reused for sending a sms code but we are not sure if  it will not break our state machine if called from SMS entry page.
              //
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
      },
    );
  }

  void verifySmsCode() {
    Either<AuthFailure, Unit> failureOrSuccess;

    state.verificationIdOption.fold(
      () {
        //Verification id does not exist. This should not happen
      },
      (String verificationId) async {
        emit(state.copyWith(isInProgress: true, failureOption: none()));
        failureOrSuccess = await _authService.verifySmsCode(
            smsCode: state.smsCode, verificationId: verificationId);
        failureOrSuccess.fold(
          (AuthFailure failure) {
            emit(state.copyWith(
                failureOption: some(failure), isInProgress: false));
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
