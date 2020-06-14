import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/app_theme.dart';
import 'package:learningwords/redux/actions/settings.dart';
import 'package:learningwords/models/app_state.dart';
import 'package:redux/redux.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel vm) {
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

class _ViewModel {
  final ThemeData themeData;
  final Function(ThemeData) toggleTheme;

  _ViewModel({this.themeData, this.toggleTheme});

  factory _ViewModel.create(Store<AppState> store) {
    _switchTheme(ThemeData theme) {
      store.dispatch(ToggleThemeAction(theme));
    }

    return _ViewModel(
      toggleTheme: _switchTheme,
      themeData: store.state.themeData,
    );
  }
}
