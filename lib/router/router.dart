import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spisok_pokupok/features/home/view/home_screen.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';
import 'package:spisok_pokupok/features/info/view/addList/add_list.dart';
import 'package:spisok_pokupok/features/info/view/addList/view/final_add/view/final_add_list.dart';
import 'package:spisok_pokupok/features/info/view/info_screen.dart';
import 'package:spisok_pokupok/features/info/view/show_card/view/show_card_screen.dart';
import 'package:spisok_pokupok/features/onboarding/view/onboarding.dart';
import 'package:spisok_pokupok/features/onboarding/widget/onboarding_page.dart';
import 'package:spisok_pokupok/features/profile/view/profile_screen.dart';
import 'package:spisok_pokupok/features/przepisy/view/feachers/info_about_the_dish/view/info_about_the_dish_screen.dart';
import 'package:spisok_pokupok/features/przepisy/view/przepisy_screen.dart';
import 'package:spisok_pokupok/features/splash/view/splash_screen.dart';
import 'package:spisok_pokupok/localStorage/LisBoxses/list_box.dart';
import '../features/favorite/view/favorite_screen.dart';
import '../features/profile/view/edit/view/edit_profile_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingViewRoute.page, path: '/onboard', children: [
          AutoRoute(page: OnboardingRouteRoute.page, path: 'page1'),
          AutoRoute(page: OnboardingRouteRoute.page, path: 'page2'),
          AutoRoute(page: OnboardingRouteRoute.page, path: 'page3'),
        ]),
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: HomeRoute.page, path: '/home', children: [
          AutoRoute(page: InfoRoute.page, path: 'info'),
          // AutoRoute(page: PrzepisyRoute.page, path: 'przepisy'),
          // AutoRoute(page: FavoriteRoute.page, path: 'favorit'),
          AutoRoute(page: ProfileRoute.page, path: 'profile'),
        ]),
        AutoRoute(page: ShowCardRoute.page, path: '/show_card'),
        AutoRoute(page: AddListRoute.page, path: '/Add'),
        AutoRoute(page: FinalAddListRoute.page, path: '/finalAdd'),
        AutoRoute(page: InfoAboutTheDishRoute.page, path: '/infoabouddish'),
        // AutoRoute(page: EditProfileRoute.page, path: '/edit_profile')
      ];
}
