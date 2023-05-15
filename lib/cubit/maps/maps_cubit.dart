import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/maps/map_model.dart';
import '../../data/remote/map_service.dart';

part 'maps_cubit.freezed.dart';
part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapService service;
  MapsCubit(
    this.service,
  ) : super(const MapsState.initial());

  void getCurrentPosition() async {
    emit(const MapsState.loading());
    final result = await service.getCurrentPosition();
    result.fold(
      (l) => emit(MapsState.error(l)),
      (r) => emit(MapsState.loaded(r)),
    );
  }

  void getSelectedPosition(double lat, double long) async {
    emit(const MapsState.loading());
    final result = await service.getPosition(lat: lat, long: long);
    result.fold(
      (l) => emit(MapsState.error(l)),
      (r) => emit(MapsState.loaded(r)),
    );
  }

  void setInitial() {
    emit(const MapsState.initial());
  }

  void setValue(MapModel data) {
    emit(MapsState.loaded(data));
  }
}
