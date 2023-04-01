import 'package:flutter/material.dart' show BuildContext;
import 'package:online_photo_libery/dialogs/generic_dialogs.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) async {
  return await showGenericDialog(
    context: context,
    title: 'Delete account',
    content:
        'Are you sure you whant to delete your account? You cannot undo this operation',
    optionBuilder: () => {
      'Cancel': false,
      'Delete account': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
