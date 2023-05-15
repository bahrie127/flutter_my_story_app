import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/list_story/list_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/logout/logout_cubit.dart';
import 'package:flutter_my_story_app/ui/pages/add_story_page.dart';
import 'package:flutter_my_story_app/ui/pages/login_page.dart';
import 'package:flutter_my_story_app/ui/widgets/story_card.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();

  @override
  void initState() {
    context.read<ListStoryCubit>().getAllStory();
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<ListStoryCubit>().getNextAllStory();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Story App'),
        actions: [
          BlocConsumer<LogoutCubit, LogoutState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.go(LoginPage.routeName);
              }
            },
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return IconButton(
                onPressed: () {
                  context.read<LogoutCubit>().logout();
                },
                icon: const Icon(Icons.logout_outlined),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: BlocBuilder<ListStoryCubit, ListStoryState>(
            builder: (context, state) {
              if (state is ListStoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ListStoryError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is ListStoryLoaded) {
                return ListView.builder(
                  controller: controller,
                  itemBuilder: (context, index) {
                    if(index == state.stories.length){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return StoryCard(story: state.stories[index]);
                  },
                  itemCount: state.hasMore!
                      ? state.stories.length + 1
                      : state.stories.length,
                );
              }

              return const Center(
                child: Text('No data'),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddStoryPage.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
