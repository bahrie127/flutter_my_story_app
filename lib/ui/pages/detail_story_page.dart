import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_my_story_app/cubit/detail_story/detail_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/maps/maps_cubit.dart';
import 'package:flutter_my_story_app/data/models/maps/map_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/list_story_response_model.dart';

class DetailStoryPage extends StatefulWidget {
  static const routeName = '/detail';
  const DetailStoryPage({
    Key? key,
    required this.storyId,
  }) : super(key: key);
  final String storyId;

  @override
  State<DetailStoryPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailStoryPage> {
  @override
  void initState() {
    context.read<DetailStoryCubit>().getStoryDetail(widget.storyId);

    super.initState();
  }

  final Set<Marker> markers = {};

  void _createMarker(MapModel model) {
    if (model.latLng != null) {
      final marker = Marker(
        markerId: const MarkerId("curr_position"),
        infoWindow: InfoWindow(title: model.address),
        position: LatLng(model.latLng!.latitude, model.latLng!.longitude),
      );

      markers.add(marker);
      // setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail Restaurant')),
        body: BlocBuilder<DetailStoryCubit, DetailStoryState>(
          builder: (context, state) {
            if (state is DetailStoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is DetailStoryError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is DetailStoryLoaded) {
              if (state.story.lat != null && state.story.lon != null) {
                context
                    .read<MapsCubit>()
                    .getSelectedPosition(state.story.lat!, state.story.lon!);
              } else {
                context.read<MapsCubit>().setInitial();
              }

              return SafeArea(
                child: details(state.story),
              );
            }

            return const Center(
              child: Text('data not found'),
            );
          },
        ));
  }

  Widget details(Story story) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          child: CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: story.photoUrl!,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: const Text(
            'Name',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            story.description!,
            textAlign: TextAlign.justify,
            style: TextStyle(
                letterSpacing: 1, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            'Address',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<MapsCubit, MapsState>(
          builder: (context, state) {
            return state.maybeMap(
              orElse: () => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('No Address'),
              ),
              loading: (value) => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (data) {
                _createMarker(data.data);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Expanded(
                    child: Column(
                      children: [
                        Text(
                          data.data.address!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 200,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            markers: markers,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                data.data.latLng!.latitude,
                                data.data.latLng!.longitude,
                              ),
                              zoom: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        )
      ],
    );
  }
}
