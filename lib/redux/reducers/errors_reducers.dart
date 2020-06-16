import 'package:learningwords/redux/actions/errors_actions.dart';
import 'package:learningwords/redux/state/errors_state.dart';
import 'package:redux/redux.dart';

final errorReducer = combineReducers<ErrorState>([
  TypedReducer<ErrorState, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<ErrorState, ErrorHandledAction>(_errorHandledReducer),
]);

ErrorState _errorOccurredReducer(
    ErrorState errorState, ErrorOccurredAction action) {
  return errorState.copyWith(error: true, message: action.message);
}

ErrorState _errorHandledReducer(
    ErrorState errorState, ErrorHandledAction action) {
  return errorState.copyWith(error: false, message: "");
}
