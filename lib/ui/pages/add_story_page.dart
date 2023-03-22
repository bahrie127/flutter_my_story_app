import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/add_story/add_story_cubit.dart';
import 'package:flutter_my_story_app/data/models/story_request_model.dart';
import 'package:flutter_my_story_app/ui/pages/home_page.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryPage extends StatefulWidget {
  const AddStoryPage({super.key});

  @override
  State<AddStoryPage> createState() => _AddStoryPageState();
}

class _AddStoryPageState extends State<AddStoryPage> {
  TextEditingController? _descController;
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
                    EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<AddStoryCubit, AddStoryState>(
              listener: (context, state) {
                if (state is AddStoryLoaded) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
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
                    if (_imageFile == null || _descController!.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Image and description is mandatory'),
                        ),
                      );
                    } else {
                      context.read<AddStoryCubit>().addStory(
                            StoryRequestModel(
                              description: _descController!.text,
                              image: _imageFile!,
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
