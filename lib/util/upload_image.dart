import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

Future<bool> uploadImg({required File file, required String userId}) async =>
    FirebaseStorage.instance
        .ref(userId)
        .child(const Uuid().v4())
        .putFile(file)
        .then((_) => true)
        .catchError((_) => false);
