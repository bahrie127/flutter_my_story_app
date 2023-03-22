import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/add_story/add_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/detail_story/detail_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/list_story/list_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/login/login_cubit.dart';
import 'package:flutter_my_story_app/cubit/logout/logout_cubit.dart';
import 'package:flutter_my_story_app/cubit/register/register_cubit.dart';
import 'package:flutter_my_story_app/data/local/auth_preferences.dart';
import 'package:flutter_my_story_app/data/remote/auth_service.dart';
import 'package:flutter_my_story_app/data/remote/story_service.dart';
import 'package:flutter_my_story_app/ui/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            AuthService(),
            AuthPreference(
              SharedPreferences.getInstance(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(AuthService()),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(
            AuthPreference(
              SharedPreferences.getInstance(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ListStoryCubit(
            StoryService(
              authPreference: AuthPreference(SharedPreferences.getInstance()),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => DetailStoryCubit(
            StoryService(
              authPreference: AuthPreference(SharedPreferences.getInstance()),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AddStoryCubit(
            StoryService(
              authPreference: AuthPreference(SharedPreferences.getInstance()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
