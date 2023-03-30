import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_photo_libery/firebase_options.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online PhotoLibery',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const PhotoLiberyScaffold(),
    );
  }
}

class PhotoLiberyScaffold extends StatelessWidget {
  const PhotoLiberyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
