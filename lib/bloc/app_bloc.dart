import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:online_photo_libery/auth/auth_error.dart';
import 'package:online_photo_libery/util/upload_image.dart';

part 'app_events.dart';
part 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppStateLogOut(
            isLoading: false,
          ),
        ) {
    on<AppEventGoToRegistration>(
      (event, emit) {
        emit(
          const AppStateIsInRegistrationView(
            isLoading: false,
          ),
        );
      },
    );
    on<AppEventLogIn>(
      (event, emit) async {
        emit(
          const AppStateLogOut(
            isLoading: true,
          ),
        );
        final email = event.email;
        final password = event.password;

        try {
          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final user = userCredential.user;
          final images = await _getImages(user!.uid);
          emit(
            AppStateLoggedIn(
              user: user,
              images: images,
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateLogOut(
              isLoading: false,
              authError: AuthError.fromExeption(e),
            ),
          );
        }
      },
    );
    on<AppEventGoToLogin>(
      (event, emit) {
        emit(
          const AppStateLogOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AppEventRegister>(
      (event, emit) async {
        emit(
          const AppStateIsInRegistrationView(
            isLoading: true,
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          final credentials =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          emit(
            AppStateLoggedIn(
              user: credentials.user!,
              images: const [],
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateIsInRegistrationView(
              isLoading: false,
              authError: AuthError.fromExeption(e),
            ),
          );
        }
      },
    );
    on<AppEventLogOut>(
      (event, emit) async {
        emit(
          const AppStateLogOut(
            isLoading: true,
          ),
        );
        await FirebaseAuth.instance.signOut();
        emit(
          const AppStateLogOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AppEventInitialize>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AppStateLogOut(
              isLoading: false,
            ),
          );
        } else {
          final images = await _getImages(user.uid);
          emit(
            AppStateLoggedIn(
              user: user,
              images: images,
              isLoading: false,
            ),
          );
        }
      },
    );
    on<AppEventDeleteAccount>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AppStateLogOut(
              isLoading: false,
            ),
          );
          return;
        }
        emit(
          AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: true,
          ),
        );
        try {
          final folderContents =
              await FirebaseStorage.instance.ref(user.uid).listAll();
          for (var item in folderContents.items) {
            await item.delete().catchError((e) {
              if (e is FirebaseAuthException) {
                emit(
                  AppStateLoggedIn(
                    images: state.images ?? [],
                    user: user,
                    isLoading: true,
                    authError: AuthError.fromExeption(e),
                  ),
                );
              }
            });
          }
          await user.delete();
          await FirebaseAuth.instance.signOut();
          emit(const AppStateLogOut(
            isLoading: false,
          ));
        } on FirebaseAuthException catch (e) {
          emit(
            AppStateLoggedIn(
              user: user,
              images: state.images ?? [],
              isLoading: false,
              authError: AuthError.fromExeption(e),
            ),
          );
        } on FirebaseException {
          emit(
            const AppStateLogOut(
              isLoading: false,
            ),
          );
        }
      },
    );
    on<AppEventUploadImage>((event, emit) async {
      final user = state.user;
      if (user == null) {
        emit(
          const AppStateLogOut(
            isLoading: false,
          ),
        );
        return;
      }
      emit(
        AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: true,
        ),
      );

      final file = File(event.filePathToUpload);
      await uploadImg(
        file: file,
        userId: user.uid,
      );
      final images = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
          user: user,
          images: images,
          isLoading: false,
        ),
      );
    });
  }

  Future<Iterable<Reference>> _getImages(String userId) =>
      FirebaseStorage.instance
          .ref(userId)
          .list()
          .then((listResult) => listResult.items);
}
