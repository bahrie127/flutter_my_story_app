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
  final int? page;
  final int? size;
  final bool? hasMore;
  const ListStoryLoaded({
    required this.stories,
    this.page = 0,
    this.size = 10,
    this.hasMore = true,
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
