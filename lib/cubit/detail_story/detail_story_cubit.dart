import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_my_story_app/data/remote/story_service.dart';

import '../../data/models/list_story_response_model.dart';

part 'detail_story_state.dart';

class DetailStoryCubit extends Cubit<DetailStoryState> {
  final StoryService service;
  DetailStoryCubit(
    this.service,
  ) : super(DetailStoryInitial());

  void getStoryDetail(String id) async {
    emit(DetailStoryLoading());
    final result = await service.getStoryDetail(id);
    result.fold(
      (l) => emit(DetailStoryError(message: l.message)),
      (r) => emit(DetailStoryLoaded(story: r.story!)),
    );
  }
}
