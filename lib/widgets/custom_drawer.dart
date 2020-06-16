import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/app_theme.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:learningwords/viewmodels/settings_viewmodel.dart';
import 'package:redux/redux.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
      converter: (Store<AppState> store) => SettingsViewModel.create(store),
      builder: (BuildContext context, SettingsViewModel vm) {
        return Drawer(
          child: Row(
            children: [
              Switch(
                value: vm.themeData == AppTheme.darkTheme,
                onChanged: (bool value) {
                  vm.toggleTheme(
                    value ? AppTheme.darkTheme : AppTheme.lightTheme,
                  );
                },
              ),
              Text("Dark Theme"),
            ],
          ),
        );
      },
    );
  }
}
