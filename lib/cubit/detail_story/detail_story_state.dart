part of 'detail_story_cubit.dart';

abstract class DetailStoryState extends Equatable {
  const DetailStoryState();

  @override
  List<Object> get props => [];
}

class DetailStoryInitial extends DetailStoryState {}

class DetailStoryLoading extends DetailStoryState {}

class DetailStoryLoaded extends DetailStoryState {
  final Story story;
  const DetailStoryLoaded({
    required this.story,
  });

  @override
  List<Object> get props => [story];
}

class DetailStoryError extends DetailStoryState {
  final String message;
  const DetailStoryError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}