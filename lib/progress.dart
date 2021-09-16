import 'package:equatable/equatable.dart';

abstract class Progress<T> with EquatableMixin {
  final isIdle = false;
  final isActive = false;
  final isCompleted = false;
  final isFailed = false;

  get props => [runtimeType, T];

  Progress<A> cast<A>();
}

class Idle<T> extends Progress<T> {
  final isIdle = true;

  Idle<A> cast<A>() => Idle();
}

class Active<T> extends Progress<T> {
  final isActive = true;

  Active<A> cast<A>() => Active();
}

class Completed<T> extends Progress<T> {
  final isCompleted = true;

  Completed<A> cast<A>() => Completed();
}

class Failed<T, Reason> extends Progress<T> {
  final isFailed = true;
  final Reason reason;

  get props => [reason, ...super.props];

  Failed(this.reason);

  Failed<A, Reason> cast<A>() => Failed(reason);
}
