part of 'onboarding_bloc_bloc.dart';

sealed class OnboardingBlocEvent extends Equatable {
  const OnboardingBlocEvent();

  @override
  List<Object> get props => [];
}


class NewScreen extends OnboardingBlocEvent{
  final TabsRouter routers;
  final BuildContext context;
  const NewScreen({required this.routers, required this.context});
}

class OnSkip extends OnboardingBlocEvent{
  final BuildContext context;

  const OnSkip({required this.context});

}




