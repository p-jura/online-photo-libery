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
class AppStatLoggedIn extends AppState {
  const AppStatLoggedIn({
    required super.isLoading,
    required super.authError,
  });
}
