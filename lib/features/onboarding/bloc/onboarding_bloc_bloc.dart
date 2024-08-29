import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spisok_pokupok/router/router.dart';

part 'onboarding_bloc_event.dart';
part 'onboarding_bloc_state.dart';

class OnboardingBlocBloc
    extends Bloc<OnboardingBlocEvent, OnboardingBlocState> {
  OnboardingBlocBloc() : super(OnboardingBlocInitial()) {
    on<NewScreen>((event, emit) {
      int activeIndexs = event.routers.activeIndex;
      switch (activeIndexs) {
        case 0:
          event.routers.setActiveIndex(activeIndexs + 1);
        case 1:
          textButton = 'Начать';
          emit(TextButtonState(textButton: textButton));
          event.routers.setActiveIndex(activeIndexs + 1);
        case 2:
          event.context.replaceRoute(const HomeRoute());
          _setDataFromStorage();
          break;
      }
    });
    on<OnSkip>((event, emit) {
      event.context.replaceRoute(const HomeRoute());
      _setDataFromStorage();
    });
  }
  String textButton = 'Далее';

  void _setDataFromStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_isSave', true);
  }
}
