import 'package:equatable/equatable.dart';

/// Base event cho Worker Detail
abstract class WorkerDetailEvent extends Equatable {
  const WorkerDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load worker detail
class WorkerDetailLoaded extends WorkerDetailEvent {
  const WorkerDetailLoaded();
}

/// Event: Hire worker button clicked
class WorkerDetailHireClicked extends WorkerDetailEvent {
  final double? proposedPrice;

  const WorkerDetailHireClicked({this.proposedPrice});

  @override
  List<Object?> get props => [proposedPrice];
}

/// Event: Call worker
class WorkerDetailCallClicked extends WorkerDetailEvent {
  const WorkerDetailCallClicked();
}

/// Event: Chat with worker
class WorkerDetailChatClicked extends WorkerDetailEvent {
  const WorkerDetailChatClicked();
}

