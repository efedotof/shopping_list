import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spisok_pokupok/Theme/repositories/theme_settings.dart';
import 'package:spisok_pokupok/Theme/theme.dart';
import 'package:spisok_pokupok/ads/cubit/ads_cubit.dart';
import 'package:spisok_pokupok/ads/repository/ads_repository.dart';
import 'package:spisok_pokupok/features/info/bloc/info_bloc_bloc.dart';
import 'package:spisok_pokupok/features/profile/bloc/Profile/profile_cubit.dart';
import 'package:spisok_pokupok/features/profile/bloc/cubit/auth_cubit.dart';
import 'package:spisok_pokupok/localStorage/LisBoxses/list_box.dart';
import 'package:spisok_pokupok/localStorage/favoritBoxses/favorit_box_receptor.dart';
import 'package:spisok_pokupok/router/router.dart';

import 'Theme/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  //repo
  final themeRepository = ThemeRepository(preferences: prefs);
  final adsRepository = AdsRepository();
  await Hive.initFlutter();
  Hive.registerAdapter(ListBoxAdapter());
  Hive.registerAdapter(FavoritboxreceptorAdapter());
  await Hive.openBox<ListBox>('listbox');
  await Hive.openBox<Favoritboxreceptor>('favorit_recip');

  // await Supabase.initialize(
  //   url: 'https://umsyqyarruvyaaembkpl.supabase.co',
  //   anonKey:
  //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVtc3lxeWFycnV2eWFhZW1ia3BsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE0MDQyODEsImV4cCI6MjAzNjk4MDI4MX0.eVNxfwOHvHZopIZWeHm6YQRYDqz8OI_3qhEsObFaG0E',
  // );
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => InfoBlocBloc(),
      ),
      BlocProvider(
        create: (context) => ThemeCubit(interf: themeRepository),
      ),
      BlocProvider(create: (context) => ProfileCubit(context: context)),
      BlocProvider(create: (context) => AuthCubit()),
      BlocProvider(create: (context) => AdsCubit(interf: adsRepository)),
    ],
    
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: state.isDark ? dartTheme : lightTheme,
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}