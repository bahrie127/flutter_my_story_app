import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_my_story_app/data/models/story_request_model.dart';

import 'package:flutter_my_story_app/data/remote/story_service.dart';

part 'add_story_state.dart';

class AddStoryCubit extends Cubit<AddStoryState> {
  final StoryService service;
  AddStoryCubit(
    this.service,
  ) : super(AddStoryInitial());

  void addStory(StoryRequestModel data) async {
    emit(AddStoryLoading());
    final result = await service.addStory(data);
    result.fold(
      (l) => emit(AddStoryError(message: l.message)),
      (r) => emit(AddStoryLoaded(message: r.message)),
    );
  }
}
