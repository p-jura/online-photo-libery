import 'package:flutter/material.dart' show BuildContext;
import 'package:online_photo_libery/dialogs/generic_dialogs.dart';

Future<bool> showLogOutDialog(BuildContext context) async {
  return await showGenericDialog(
    context: context,
    title: 'Log out',
    content:
        'Are you sure you whant to log out?',
    optionBuilder: () => {
      'Cancel': false,
      'Log out': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
