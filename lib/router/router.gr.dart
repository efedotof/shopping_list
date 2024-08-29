// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddListRoute.name: (routeData) {
      final args = routeData.argsAs<AddListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddListScreen(
          key: args.key,
          bloc: args.bloc,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfileScreen(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteScreen(),
      );
    },
    FinalAddListRoute.name: (routeData) {
      final args = routeData.argsAs<FinalAddListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FinalAddListScreen(
          key: args.key,
          bloc: args.bloc,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    InfoAboutTheDishRoute.name: (routeData) {
      final args = routeData.argsAs<InfoAboutTheDishRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InfoAboutTheDishScreen(
          key: args.key,
          title: args.title,
          rating: args.rating,
          cookTime: args.cookTime,
          calories: args.calories,
          introduction: args.introduction,
          ingredients: args.ingredients,
          instructions: args.instructions,
        ),
      );
    },
    InfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const InfoScreen(),
      );
    },
    OnboardingRouteRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingRouteRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OnboardingPageScreen(
          key: args.key,
          image: args.image,
          title: args.title,
          description: args.description,
          buttonText: args.buttonText,
        ),
      );
    },
    OnboardingViewRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingViewScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    PrzepisyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrzepisyScreen(),
      );
    },
    ShowCardRoute.name: (routeData) {
      final args = routeData.argsAs<ShowCardRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ShowCardScreen(
          key: args.key,
          targetIndex: args.targetIndex,
          box: args.box,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [AddListScreen]
class AddListRoute extends PageRouteInfo<AddListRouteArgs> {
  AddListRoute({
    Key? key,
    required InfoBlocBloc bloc,
    List<PageRouteInfo>? children,
  }) : super(
          AddListRoute.name,
          args: AddListRouteArgs(
            key: key,
            bloc: bloc,
          ),
          initialChildren: children,
        );

  static const String name = 'AddListRoute';

  static const PageInfo<AddListRouteArgs> page =
      PageInfo<AddListRouteArgs>(name);
}

class AddListRouteArgs {
  const AddListRouteArgs({
    this.key,
    required this.bloc,
  });

  final Key? key;

  final InfoBlocBloc bloc;

  @override
  String toString() {
    return 'AddListRouteArgs{key: $key, bloc: $bloc}';
  }
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteScreen]
class FavoriteRoute extends PageRouteInfo<void> {
  const FavoriteRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FinalAddListScreen]
class FinalAddListRoute extends PageRouteInfo<FinalAddListRouteArgs> {
  FinalAddListRoute({
    Key? key,
    required InfoBlocBloc bloc,
    List<PageRouteInfo>? children,
  }) : super(
          FinalAddListRoute.name,
          args: FinalAddListRouteArgs(
            key: key,
            bloc: bloc,
          ),
          initialChildren: children,
        );

  static const String name = 'FinalAddListRoute';

  static const PageInfo<FinalAddListRouteArgs> page =
      PageInfo<FinalAddListRouteArgs>(name);
}

class FinalAddListRouteArgs {
  const FinalAddListRouteArgs({
    this.key,
    required this.bloc,
  });

  final Key? key;

  final InfoBlocBloc bloc;

  @override
  String toString() {
    return 'FinalAddListRouteArgs{key: $key, bloc: $bloc}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InfoAboutTheDishScreen]
class InfoAboutTheDishRoute extends PageRouteInfo<InfoAboutTheDishRouteArgs> {
  InfoAboutTheDishRoute({
    Key? key,
    required String title,
    required double rating,
    required String cookTime,
    required String calories,
    required String introduction,
    required List<Map<String, dynamic>> ingredients,
    required List<String> instructions,
    List<PageRouteInfo>? children,
  }) : super(
          InfoAboutTheDishRoute.name,
          args: InfoAboutTheDishRouteArgs(
            key: key,
            title: title,
            rating: rating,
            cookTime: cookTime,
            calories: calories,
            introduction: introduction,
            ingredients: ingredients,
            instructions: instructions,
          ),
          initialChildren: children,
        );

  static const String name = 'InfoAboutTheDishRoute';

  static const PageInfo<InfoAboutTheDishRouteArgs> page =
      PageInfo<InfoAboutTheDishRouteArgs>(name);
}

class InfoAboutTheDishRouteArgs {
  const InfoAboutTheDishRouteArgs({
    this.key,
    required this.title,
    required this.rating,
    required this.cookTime,
    required this.calories,
    required this.introduction,
    required this.ingredients,
    required this.instructions,
  });

  final Key? key;

  final String title;

  final double rating;

  final String cookTime;

  final String calories;

  final String introduction;

  final List<Map<String, dynamic>> ingredients;

  final List<String> instructions;

  @override
  String toString() {
    return 'InfoAboutTheDishRouteArgs{key: $key, title: $title, rating: $rating, cookTime: $cookTime, calories: $calories, introduction: $introduction, ingredients: $ingredients, instructions: $instructions}';
  }
}

/// generated route for
/// [InfoScreen]
class InfoRoute extends PageRouteInfo<void> {
  const InfoRoute({List<PageRouteInfo>? children})
      : super(
          InfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'InfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingPageScreen]
class OnboardingRouteRoute extends PageRouteInfo<OnboardingRouteRouteArgs> {
  OnboardingRouteRoute({
    Key? key,
    required String image,
    required String title,
    required String description,
    required String buttonText,
    List<PageRouteInfo>? children,
  }) : super(
          OnboardingRouteRoute.name,
          args: OnboardingRouteRouteArgs(
            key: key,
            image: image,
            title: title,
            description: description,
            buttonText: buttonText,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingRouteRoute';

  static const PageInfo<OnboardingRouteRouteArgs> page =
      PageInfo<OnboardingRouteRouteArgs>(name);
}

class OnboardingRouteRouteArgs {
  const OnboardingRouteRouteArgs({
    this.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  final Key? key;

  final String image;

  final String title;

  final String description;

  final String buttonText;

  @override
  String toString() {
    return 'OnboardingRouteRouteArgs{key: $key, image: $image, title: $title, description: $description, buttonText: $buttonText}';
  }
}

/// generated route for
/// [OnboardingViewScreen]
class OnboardingViewRoute extends PageRouteInfo<void> {
  const OnboardingViewRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingViewRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingViewRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrzepisyScreen]
class PrzepisyRoute extends PageRouteInfo<void> {
  const PrzepisyRoute({List<PageRouteInfo>? children})
      : super(
          PrzepisyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrzepisyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShowCardScreen]
class ShowCardRoute extends PageRouteInfo<ShowCardRouteArgs> {
  ShowCardRoute({
    Key? key,
    required int targetIndex,
    required ListBox box,
    List<PageRouteInfo>? children,
  }) : super(
          ShowCardRoute.name,
          args: ShowCardRouteArgs(
            key: key,
            targetIndex: targetIndex,
            box: box,
          ),
          initialChildren: children,
        );

  static const String name = 'ShowCardRoute';

  static const PageInfo<ShowCardRouteArgs> page =
      PageInfo<ShowCardRouteArgs>(name);
}

class ShowCardRouteArgs {
  const ShowCardRouteArgs({
    this.key,
    required this.targetIndex,
    required this.box,
  });

  final Key? key;

  final int targetIndex;

  final ListBox box;

  @override
  String toString() {
    return 'ShowCardRouteArgs{key: $key, targetIndex: $targetIndex, box: $box}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
