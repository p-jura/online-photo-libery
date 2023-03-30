import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart';

const Map<String, AuthError> authErrorMapping = {};

@immutable
abstract class AuthError {
  final String title;
  final String dialog;

  const AuthError({
    required this.title,
    required this.dialog,
  });

  factory AuthError.fromExeption(FirebaseAuthException exeption) =>
      authErrorMapping[exeption.code.toLowerCase().trim()] ??
      const AuthErrorUnknown();
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          title: 'Authentication error',
          dialog: 'Unknown authentication error.',
        );
}


@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          title: 'No current user!',
          dialog: 'No current user with this information was found',
        );
}
