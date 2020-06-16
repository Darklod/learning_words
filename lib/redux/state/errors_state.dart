import 'package:flutter/foundation.dart';

@immutable
class ErrorState {
  final bool error;
  final String message;

  const ErrorState({@required this.error, @required this.message});

  ErrorState.initial()
      : error = false,
        message = "";

  ErrorState copyWith({bool error, String message}) {
    return ErrorState(
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map toJson() => null;

  factory ErrorState.fromJson(Map json) {
    return ErrorState.initial();
  }
}
