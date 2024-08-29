import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spisok_pokupok/Theme/cubit/theme_cubit.dart';
import 'package:spisok_pokupok/features/profile/bloc/Profile/profile_cubit.dart';


@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Настройки'),
            elevation: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // if (state is UserIsAuth) ...[
              //   const CircleAvatar(
              //     radius: 50,
              //     backgroundColor: Colors.green,
              //   ),
              //   const SizedBox(height: 10),
              //   const Center(
              //     child: Text(
              //       'Username',
              //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   const SizedBox(height: 30),
              //   Card(
              //     child: ListTile(
              //         leading: const Icon(Icons.edit),
              //         title: const Text('Редактировать профиль'),
              //         onTap: () => context.pushRoute(const EditProfileRoute())),
              //   ),
              //   Card(
              //     child: ListTile(
              //       leading: const Icon(Icons.lock),
              //       title: const Text('Изменить пароль'),
              //       onTap: () {
              //         // Navigate to change password screen
              //       },
              //     ),
              //   ),
              //   Card(
              //     child: ListTile(
              //       leading: const Icon(Icons.info),
              //       title: const Text('Очистить все'),
              //       onTap: () => context.read<ProfileCubit>().clearAppCash(context),
              //     ),
              //   ),
              //   BlocBuilder<ThemeCubit, ThemeState>(
              //     builder: (context, themeState) {
              //       return Card(
              //         child: ListTile(
              //           leading: themeState.isDark
              //               ? const Icon(Icons.light_mode)
              //               : const Icon(Icons.dark_mode),
              //           title: const Text('Тема'),
              //           onTap: () {
              //             // Navigate to update screen
              //           },
              //           trailing: Switch(
              //             value: themeState.isDark,
              //             onChanged: (value) => _setTheme(context, value),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              //   Card(
              //     child: ListTile(
              //       leading: const Icon(Icons.logout),
              //       title: const Text('Выход'),
              //       onTap: () => context.read<ProfileCubit>().exitSupaBase(context),
              //     ),
              //   ),
              // ] else if (state is UserIsNotAuth) ...[]
              
              
              
              
              
                // const Center(
                //   child: Text(
                //     'Вы не авторизованы',
                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                //   ),
                // ),
                const SizedBox(height: 30),
                // Card(
                //   child: ListTile(
                //     leading: const Icon(Icons.login),
                //     title: const Text('Войти'),
                //     onTap: () => context.read<ProfileCubit>().authUserShow(context),
                //   ),
                // ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Очистить все'),
                    onTap: () => context.read<ProfileCubit>().clearAppCash(context),
                  ),
                ),

                BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return Card(
                      child: ListTile(
                        leading: themeState.isDark
                            ? const Icon(Icons.light_mode)
                            : const Icon(Icons.dark_mode),
                        title: const Text('Тема'),
                        onTap: () {
                          // Navigate to update screen
                        },
                        trailing: Switch(
                          value: themeState.isDark,
                          onChanged: (value) => _setTheme(context, value),
                        ),
                      ),
                    );
                  },
                ),
              ],
            
          ),
        );
      },
    );
  }

  void _setTheme(BuildContext context, bool value) {
    context.read<ThemeCubit>().setThemBrigth(value ? Brightness.dark : Brightness.light);
  }
}
