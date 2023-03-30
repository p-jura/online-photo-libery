import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/foundation.dart';

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-allready-in-use': AuthErrorEmailAllreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

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

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          dialog:
              'You need to log out and log back in again, in order to perform this operation.',
        );
}

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          dialog: 'You cannot register using this method at this moment.',
        );
}

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          title: 'User not found',
          dialog: 'The given user was not found in the database.',
        );
}

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          title: 'Weak password',
          dialog: 'Please choose a stronger passowrd with more characters.',
        );
}

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          title: 'Invalid email',
          dialog: 'Please check the email and try again',
        );
}

@immutable
class AuthErrorEmailAllreadyInUse extends AuthError {
  const AuthErrorEmailAllreadyInUse()
      : super(
          title: 'Email allready in use',
          dialog: 'Please choose another email to register',
        );
}
