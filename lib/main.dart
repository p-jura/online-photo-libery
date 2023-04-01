import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_photo_libery/dialogs/show_auth_error_dialog.dart';
import 'package:online_photo_libery/firebase_options.dart';
import 'package:online_photo_libery/loading/loading_screen.dart';
import 'package:online_photo_libery/views/login_view.dart';
import 'package:online_photo_libery/views/photo_gallery.dart';
import 'package:online_photo_libery/views/register_view.dart';

import 'bloc/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const PhotoLiberyRootWidget(),
  );
}

class PhotoLiberyRootWidget extends StatelessWidget {
  const PhotoLiberyRootWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()
        ..add(
          const AppEventInitialize(),
        ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Online PhotoGallery',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            if (appState.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }
            final authError = appState.authError;
            if (authError != null) {
              showAuthErrorDialog(context: context, error: authError);
            }
          },
          builder: (context, appState) {
            if (appState is AppStateLogOut) {
              return const LoginView();
            } else if (appState is AppStateLoggedIn) {
              return const PhotoGallery();
            } else if (appState is AppStateIsInRegistrationView) {
              return const RegisterView();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
