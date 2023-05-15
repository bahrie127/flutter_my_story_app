import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/add_story/add_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/maps/maps_cubit.dart';
import 'package:flutter_my_story_app/data/models/maps/map_model.dart';
import 'package:flutter_my_story_app/data/models/request/story_request_model.dart';
import 'package:flutter_my_story_app/ui/pages/home_page.dart';
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';

import '../../cubit/list_story/list_story_cubit.dart';

class AddStoryPage extends StatefulWidget {
  static const routeName = '/add';
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  TextEditingController? _descController;
  TextEditingController? _addressController;
  MapModel? mapModel;
  XFile? _imageFile;

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (photo != null) {
      _imageFile = photo;
      setState(() {});
    }
  }

  @override
  void initState() {
    _descController = TextEditingController();
    _addressController = TextEditingController();
    context.read<MapsCubit>().getCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Story')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: _imageFile != null
                  ? Image.file(
                      File(_imageFile!.path.toString()),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/place_holder.png',
                    ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFFF5A1A1),
                    ),
                  ),
                  child: const Text(
                    "Galery",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Address",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<MapsCubit, MapsState>(
              listener: (context, state) {
                state.maybeMap(
                    orElse: () =>
                        _addressController!.text = 'Location Not Found',
                    loaded: (data) {
                      mapModel = data.data;
                      _addressController!.text =
                          data.data.address ?? 'Location Not Found';
                    });
              },
              builder: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  loading: (data) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                return Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextField(
                        controller: _addressController,
                        maxLines: 2,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Address",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.push(
                            '/maps/${mapModel!.latLng!.latitude}/${mapModel!.latLng!.longitude}',
                          );
                          setState(() {});
                        },
                        child: const FittedBox(child: Text('Change\nLocation')),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<AddStoryCubit, AddStoryState>(
              listener: (context, state) {
                if (state is AddStoryLoaded) {
                  context.read<ListStoryCubit>().getAllStory();
                  context.go(HomePage.routeName);
                }
                if (state is AddStoryError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddStoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_imageFile == null ||
                        _descController!.text.isEmpty ||
                        mapModel == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              'Image, description and address is mandatory'),
                        ),
                      );
                    } else {
                      context.read<AddStoryCubit>().addStory(
                            StoryRequestModel(
                              description: _descController!.text,
                              image: _imageFile!,
                              lat: mapModel!.latLng!.latitude,
                              long: mapModel!.latLng!.longitude,
                            ),
                          );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
