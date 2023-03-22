import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/detail_story/detail_story_cubit.dart';

import '../../data/models/list_story_response_model.dart';

class DetailStoryPage extends StatefulWidget {
  const DetailStoryPage({
    Key? key,
    required this.story,
  }) : super(key: key);
  final Story story;

  @override
  State<DetailStoryPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailStoryPage> {
  @override
  void initState() {
    context.read<DetailStoryCubit>().getStoryDetail(widget.story.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detail Story')),
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
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            story.description!,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
