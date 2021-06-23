import 'package:firebase_auth/firebase_auth.dart' as firebase;

import '../../domain/auth/auth_user_model.dart';

extension FirebaseUserDomainX on firebase.User {
  AuthUserModel toDomain() {
    final AuthUserModel emptyModel = AuthUserModel.empty();
    return emptyModel.copyWith(
      id: uid,
      phoneNumber: phoneNumber ?? emptyModel.phoneNumber,
    );
  }
}
