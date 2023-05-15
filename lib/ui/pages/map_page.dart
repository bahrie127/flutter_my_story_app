import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/maps/maps_cubit.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../data/models/maps/map_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
    required this.lat,
    required this.long,
  }) : super(key: key);
  final double lat;
  final double long;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final TextEditingController _addressController = TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  void _createInitialMarker() {
    final marker = Marker(
      markerId: const MarkerId("position"),
      position: LatLng(widget.lat, widget.long),
    );

    _markers.add(marker);
  }

  Future<void> _getPosition({
    required double lat,
    required double long,
  }) async {
    _addressController.text = "Loading";

    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _addressController.text = "Please enable location service";
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _addressController.text = "Location permission needed";
        return;
      }
    }

    final info = await geo.placemarkFromCoordinates(
      lat,
      long,
    );

    if (info.isNotEmpty) {
      final place = info[0];
      _addressController.text =
          '${place.street}, ${place.subLocality}, ${place.locality},'
          ' ${place.postalCode}, ${place.country}';
    } else {
      _addressController.text = "Location not found ";
    }

    if (mounted) {
      context.read<MapsCubit>().setValue(MapModel(
            address: _addressController.text,
            latLng: LatLng(lat, long),
          ));
    }
  }

  void mapController(GoogleMapController value) {
    _mapController = value;
  }

  void setNewMarker({required double lat, required double long}) async {
    _markers.clear();
    final marker = Marker(
      markerId: const MarkerId("position"),
      position: LatLng(lat, long),
    );

    _markers.add(marker);

    _mapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, long), 15),
    );

    await _getPosition(lat: lat, long: long);
    setState(() {});
  }

  @override
  void initState() {
    _createInitialMarker();
    _getPosition(lat: widget.lat, long: widget.long);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Location'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.check_box_outlined,
              color: Colors.green,
              size: 32,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long),
                  zoom: 15,
                ),
                markers: _markers,
                onMapCreated: (controller) {
                  mapController(controller);
                },
                onTap: (LatLng latLng) {
                  setNewMarker(
                    lat: latLng.latitude,
                    long: latLng.longitude,
                  );
                },
                onLongPress: (LatLng latLng) {
                  setNewMarker(
                    lat: latLng.latitude,
                    long: latLng.longitude,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 90,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: _addressController,
                    enabled: false,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
