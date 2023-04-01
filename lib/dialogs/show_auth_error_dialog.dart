import 'package:flutter/material.dart' show BuildContext;
import 'package:online_photo_libery/auth/auth_error.dart';
import 'package:online_photo_libery/dialogs/generic_dialogs.dart';

Future<void> showAuthErrorDialog({
  required BuildContext context,
  required AuthError error,
}) async {
  return await showGenericDialog<void>(
    context: context,
    title: error.title,
    content: error.dialog,
    optionBuilder: () => {
      'ok': true,
    },
  );
}
