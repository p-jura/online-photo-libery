import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:online_photo_libery/auth/auth_error.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;

  const AppState({
    required this.isLoading,
    required this.authError,
  });
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final Iterable<Reference> images;

  const AppStateLoggedIn({
    required this.user,
    required this.images,
    required super.isLoading,
    required super.authError,
  });
  @override
  bool operator ==(other) {
    final otherClass = other;
    if (otherClass is AppStateLoggedIn) {
      return isLoading == otherClass.isLoading &&
          user == otherClass.user &&
          images.length == otherClass.images.length;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => Object.hash(
        user.uid,
        images,
      );
  @override
  String toString() => 'AppStateLoggedIn, images.lenght = ${images.length}';
}

@immutable
class AppStateLogOut extends AppState {
  const AppStateLogOut({
    required super.isLoading,
    required super.authError,
  });
  @override
  String toString() =>
      'AppStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView(
      {required super.isLoading, required super.authError});
}

extension GetUser on AppState {
  User? get user {
    final presentState = this;
    if (presentState is AppStateLoggedIn) {
      return presentState.user;
    } else {
      return null;
    }
  }
}

extension GetImages on AppState {
  Iterable<Reference>? get user {
    final presentState = this;
    if (presentState is AppStateLoggedIn) {
      return presentState.images;
    } else {
      return null;
    }
  }
}
