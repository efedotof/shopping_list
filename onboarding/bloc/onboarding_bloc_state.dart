part of 'onboarding_bloc_bloc.dart';

sealed class OnboardingBlocState extends Equatable {
  const OnboardingBlocState();
  
  @override
  List<Object> get props => [];
}

final class OnboardingBlocInitial extends OnboardingBlocState {}






class TextButtonState extends OnboardingBlocState {
  final String textButton;

  const TextButtonState({required this.textButton});
}
