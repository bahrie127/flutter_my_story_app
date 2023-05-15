import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_my_story_app/data/models/list_story_response_model.dart';
import 'package:flutter_my_story_app/data/remote/story_service.dart';

part 'list_story_state.dart';

class ListStoryCubit extends Cubit<ListStoryState> {
  final StoryService service;
  ListStoryCubit(
    this.service,
  ) : super(ListStoryInitial());

  void getAllStory() async {
    emit(ListStoryLoading());
    final result = await service.getAllStory(1, 10);
    result.fold(
      (l) => emit(ListStoryError(message: l.message)),
      (r) => emit(ListStoryLoaded(
          stories: r.listStory!,
          page: 1,
          size: 10,
          hasMore: r.listStory!.length >= 10)),
    );
  }

  void getNextAllStory() async {
    final currentState = state as ListStoryLoaded;
    final result =
        await service.getAllStory(currentState.page! + 1, currentState.size!);
    result.fold(
      (l) => emit(ListStoryError(message: l.message)),
      (r) {
        return emit(ListStoryLoaded(
          stories: [...currentState.stories, ...r.listStory!],
          page: currentState.page! + 1,
          size: currentState.size!,
          hasMore: r.listStory!.length >= currentState.size!,
        ));
      },
    );
  }
}
