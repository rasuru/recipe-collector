import 'package:equatable/equatable.dart';

abstract class Progress<Result> with EquatableMixin {
  final isIdle = false;
  final isActive = false;
  final isCompleted = false;
  final isFailed = false;

  get props => [runtimeType, Result];

  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  });
}

class Idle<Result> extends Progress<Result> {
  final isIdle = true;

  @override
  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  }) =>
      ifIdle();
}

class Active<Result> extends Progress<Result> {
  final isActive = true;

  @override
  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  }) =>
      ifActive();
}

class Completed<Result> extends Progress<Result> {
  final isCompleted = true;
  final Result result;

  get props => [result, ...super.props];

  Completed(this.result);

  @override
  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  }) =>
      ifCompleted(result);
}

class Failed<Result, Reason> extends Progress<Result> {
  final isFailed = true;
  final Reason reason;

  get props => [reason, ...super.props];

  Failed(this.reason);

  @override
  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  }) =>
      ifFailed(reason);
}
