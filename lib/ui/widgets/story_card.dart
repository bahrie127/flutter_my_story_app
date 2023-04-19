import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_story_app/ui/pages/detail_story_page.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/list_story_response_model.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
    required this.story,
  }) : super(key: key);
  final Story story;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('${DetailStoryPage.routeName}/${story.id}');
      },
      child: Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Hero(
                tag: story.photoUrl!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: story.photoUrl!,
                    width: 100,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
