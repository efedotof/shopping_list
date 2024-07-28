import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spisok_pokupok/Theme/cubit/theme_cubit.dart';
import 'package:spisok_pokupok/features/onboarding/bloc/onboarding_bloc_bloc.dart';
import 'package:spisok_pokupok/router/router.dart';

@RoutePage()
class OnboardingViewScreen extends StatefulWidget {
  const OnboardingViewScreen({
    super.key,
  });

  @override
  State<OnboardingViewScreen> createState() => _OnboardingViewScreenState();
}

class _OnboardingViewScreenState extends State<OnboardingViewScreen> {
  OnboardingBlocBloc _bloc = OnboardingBlocBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBlocBloc, OnboardingBlocState>(
      bloc: _bloc,
      builder: (context, state) {
        return AutoTabsRouter(
          routes: [
            OnboardingRouteRoute(
              image: 'assets/images/welcome.png',
              title: 'Добро пожаловать!',
              description:
                  'Сделайте свои покупки проще и быстрее, заранее составив список продуктов',
              buttonText: 'Next',
            ),
            OnboardingRouteRoute(
              image: 'assets/images/smart_categorization.png',
              title: 'Легкость покупок',
              description:
                  'Настройте свои покупки с помощью инструмента для более удобной организации продуктов.',
              buttonText: 'Next',
            ),
            OnboardingRouteRoute(
              image: 'assets/images/create_share.png',
              title: 'Создавайте и делитесь',
              description: 'Делитесь списками покупок с семьей и друзьями.',
              buttonText: 'Get started',
            ),
          ],
          transitionBuilder: (context, child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              appBar: AppBar(
                leading: BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, state) {
                    return GestureDetector(
                        onTap: () => _setTheme(context, !state.isDark),
                        child: Icon(
                            state.isDark
                                ? Icons.light_mode_outlined
                                : Icons.dark_mode_outlined,
                            color: const Color(0xFF686868)));
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => _bloc.add(OnSkip(context: context)),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFF686868)),
                      ),
                    ),
                  )
                ],
                automaticallyImplyLeading: false,
                title: const Text(
                  'Простой список покупок',
                  style: TextStyle(
                      color: Color(0xFF252E8F), fontWeight: FontWeight.normal),
                ),
                centerTitle: true,
              ),
              body: child,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => _bloc
                      .add(NewScreen(routers: tabsRouter, context: context)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF5D5FF0),
                        borderRadius: BorderRadius.circular(6)),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(_bloc.textButton,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _setTheme(BuildContext context, bool value) {
    context
        .read<ThemeCubit>()
        .setThemBrigth(value ? Brightness.dark : Brightness.light);
  }
}
