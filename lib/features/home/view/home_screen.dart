import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spisok_pokupok/features/home/bloc/home_bloc_bloc.dart';
import 'package:spisok_pokupok/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> iconList = [
      const Icon(Icons.list_alt_outlined),
      // const Icon(Icons.local_dining_outlined),
      // const Icon(Icons.favorite_border),
      const Icon(Icons.person),
    ];

    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      bloc:HomeBlocBloc()..add(ShowBottomLogin(context: context)),
      builder: (context, state) {
        
        return AutoTabsRouter(
          routes: const [
            InfoRoute(),
            // PrzepisyRoute(),
            // FavoriteRoute(),
            ProfileRoute(),
          ],
          transitionBuilder: (context, child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                },
                items: List.generate(
                    iconList.length,
                    (index) => BottomNavigationBarItem(
                          icon: iconList[index],
                          label: '',
                        )),
              ),
            );
          },
        );
      },
    );
  }
}
