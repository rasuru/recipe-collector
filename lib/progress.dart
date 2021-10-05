import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Progress<Result> with EquatableMixin {
  final isIdle = false;
  final isActive = false;
  final isCompleted = false;
  final isFailed = false;

  get props => [runtimeType, Result];

  Progress<B> map<B>(B Function(Result) fn);

  Option<Result> get maybeResult {
    final progress = this;

    return progress is Completed<Result> ? Some(progress.result) : None();
  }

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
  Idle<B> map<B>(_) => Idle();

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
  Active<B> map<B>(_) => Active();

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
  Completed<B> map<B>(fn) => Completed(fn(result));

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
  Failed<B, Reason> map<B>(_) => Failed(reason);

  @override
  B fold<B>({
    required B Function() ifIdle,
    required B Function() ifActive,
    required B Function(Result) ifCompleted,
    required B Function(dynamic) ifFailed,
  }) =>
      ifFailed(reason);
}
