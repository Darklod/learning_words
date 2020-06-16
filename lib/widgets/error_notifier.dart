import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:learningwords/redux/actions/errors_actions.dart';
import 'package:learningwords/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class ErrorNotifier extends StatelessWidget {
  final Widget child;

  ErrorNotifier({@required this.child});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ErrorViewModel>(
      converter: (Store<AppState> store) => ErrorViewModel.fromStore(store),
      builder: (context, vm) => child,
      distinct: true,
      onDidChange: (vm) {
        // Bug ? Occurs more time (https://github.com/brianegan/flutter_redux/issues/76)

        if (vm.error) {
          vm.handleError();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(vm.message),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );
  }
}

class ErrorViewModel {
  final String message;
  final Function handleError;
  final bool error;

  ErrorViewModel({this.handleError, this.message, this.error});

  static ErrorViewModel fromStore(Store<AppState> store) {
    return ErrorViewModel(
      handleError: () async => await store.dispatch(ErrorHandledAction()),
      message: store.state.error.message,
      error: store.state.error.error,
    );
  }
}
