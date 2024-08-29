// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:spisok_pokupok/features/profile/bloc/Profile/profile_cubit.dart';
// import 'package:spisok_pokupok/features/profile/bloc/cubit/auth_cubit.dart';

// import 'sign_in_button.dart';

// class SignInOptionsScreen extends StatelessWidget {
//   const SignInOptionsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

//     return BlocBuilder<AuthCubit, AuthState>(
//       builder: (context, state) {
//         return SingleChildScrollView(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: Wrap(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(15),
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           controller: emailController,
//                           decoration: const InputDecoration(
//                             labelText: 'Почта',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TextField(
//                           controller: passwordController,
//                           decoration: const InputDecoration(
//                             labelText: 'Пароль',
//                             border: InputBorder.none,
//                           ),
//                           obscureText: true,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     state is IsLoading
//                         ?Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 20.0),
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 elevation: 5.0,
//                                 backgroundColor: Colors.white,
//                                 shape: const StadiumBorder(),
//                               ),
//                               child: const Padding(
//                                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 6,),
//                                 child: CircularProgressIndicator(),
//                               ),
//                             )) :SignInButton(
//                             textLabel: 'Авторизироваться',
//                             elevation: 5.0,
//                             backgroundColor: Colors.white,
//                             onTap: () => context
//                                 .read<AuthCubit>()
//                                 .signInUserSupaBase(
//                                     context,
//                                     emailController.text,
//                                     passwordController.text),
//                           ),
                        
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Center(
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Нет аккаунта ?',
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: ' Регистрация',
//                                 style:
//                                     const TextStyle(color: Color(0xFF686868)),
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () => context
//                                       .read<ProfileCubit>()
//                                       .createAccount(context)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
