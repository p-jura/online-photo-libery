import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImagesView extends StatelessWidget {
  final Reference image;

  const ImagesView({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: image.getData(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            break;
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Image.memory(
                data,
                fit: BoxFit.cover,
              );
            } else {
              return const CircularProgressIndicator();
            }
        }
        return Container();
      },
    );
  }
}
