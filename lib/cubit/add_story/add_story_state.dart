part of 'add_story_cubit.dart';

abstract class AddStoryState extends Equatable {
  const AddStoryState();

  @override
  List<Object> get props => [];
}

class AddStoryInitial extends AddStoryState {}

class AddStoryLoading extends AddStoryState {}

class AddStoryLoaded extends AddStoryState {
  final String message;
  const AddStoryLoaded({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class AddStoryError extends AddStoryState {
  final String message;
  const AddStoryError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
