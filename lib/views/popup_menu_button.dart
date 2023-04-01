// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_photo_libery/bloc/app_bloc.dart';
import 'package:online_photo_libery/dialogs/delete_account_dialog.dart';
import 'package:online_photo_libery/dialogs/logout_dialog.dart';

enum MenuAction { logout, deletAccount }

class MainPopupMenu extends StatelessWidget {
  const MainPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogOutDialog(context);
            if (shouldLogout) {
              context.read<AppBloc>().add(
                    const AppEventLogOut(),
                  );
            }
            break;
          case MenuAction.deletAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              context.read<AppBloc>().add(
                    const AppEventDeleteAccount(),
                  );
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: MenuAction.logout,
            child: Text(
              'Log out',
            ),
          ),
          const PopupMenuItem(
            value: MenuAction.deletAccount,
            child: Text(
              'Deleta account',
            ),
          ),
        ];
      },
    );
  }
}
