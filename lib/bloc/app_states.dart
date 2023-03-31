part of 'app_bloc.dart';

@immutable
abstract class AppState {
  final bool isLoading;
  final AuthError? authError;

  const AppState({
    required this.isLoading,
    this.authError,
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
    super.authError,
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
    super.authError,
  });
  @override
  String toString() =>
      'AppStateLoggedOut, isLoading = $isLoading, authError = $authError';
}

@immutable
class AppStateIsInRegistrationView extends AppState {
  const AppStateIsInRegistrationView(
      {required super.isLoading, super.authError});
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
  Iterable<Reference>? get images {
    final presentState = this;
    if (presentState is AppStateLoggedIn) {
      return presentState.images;
    } else {
      return null;
    }
  }
}
