part of 'list_story_cubit.dart';

abstract class ListStoryState extends Equatable {
  const ListStoryState();

  @override
  List<Object> get props => [];
}

class ListStoryInitial extends ListStoryState {}

class ListStoryLoading extends ListStoryState {}

class ListStoryLoaded extends ListStoryState {
  final List<Story> stories;
  const ListStoryLoaded({
    required this.stories,
  });

  @override
  List<Object> get props => [stories];
}

class ListStoryError extends ListStoryState {
  final String message;
  const ListStoryError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}