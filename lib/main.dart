import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_my_story_app/cubit/add_story/add_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/detail_story/detail_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/list_story/list_story_cubit.dart';
import 'package:flutter_my_story_app/cubit/login/login_cubit.dart';
import 'package:flutter_my_story_app/cubit/logout/logout_cubit.dart';
import 'package:flutter_my_story_app/cubit/maps/maps_cubit.dart';
import 'package:flutter_my_story_app/cubit/register/register_cubit.dart';
import 'package:flutter_my_story_app/data/local/auth_preferences.dart';
import 'package:flutter_my_story_app/data/remote/auth_service.dart';
import 'package:flutter_my_story_app/data/remote/story_service.dart';
import 'package:flutter_my_story_app/ui/pages/add_story_page.dart';
import 'package:flutter_my_story_app/ui/pages/detail_story_page.dart';
import 'package:flutter_my_story_app/ui/pages/home_page.dart';
import 'package:flutter_my_story_app/ui/pages/login_page.dart';
import 'package:flutter_my_story_app/ui/pages/map_page.dart';
import 'package:flutter_my_story_app/ui/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'data/remote/map_service.dart';

void main() {
  setPathUrlStrategy();
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
        BlocProvider(
          create: (context) => MapsCubit(
            MapService(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routerConfig: GoRouter(
          initialLocation: LoginPage.routeName,
          redirect: (context, GoRouterState state) async {
            if (state.location == LoginPage.routeName) {
              final auth = AuthPreference(SharedPreferences.getInstance());

              if (await auth.isUserLogin()) {
                return HomePage.routeName;
              } else {
                return null;
              }
            }
            return null;
          },
          routes: [
            GoRoute(
              path: LoginPage.routeName,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              path: RegisterPage.routeName,
              builder: (context, state) => const RegisterPage(),
            ),
            GoRoute(
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
              redirect: (context, state) async {
                final auth = AuthPreference(SharedPreferences.getInstance());

                if (await auth.isUserLogin() == false) {
                  return LoginPage.routeName;
                } else {
                  return null;
                }
              },
            ),
            GoRoute(
              path: '${DetailStoryPage.routeName}/:storyId',
              builder: (context, state) => DetailStoryPage(
                storyId: state.params['storyId']!,
              ),
            ),
            GoRoute(
              path: AddStoryPage.routeName,
              builder: (context, state) => const AddStoryPage(),
            ),
            GoRoute(
              path: '/maps/:lat/:long',
              builder: (context, state) => MapPage(
                lat: double.parse(state.params['lat']!),
                long: double.parse(state.params['long']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
