import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel {
  LatLng? latLng;
  String? address;
  MapModel({
    this.latLng,
    this.address,
  });

  @override
  String toString() => 'MapModel(latLng: $latLng, address: $address)';
}
