// import 'dart:developer';

// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'dart:convert';
// import 'package:crypto/crypto.dart';

// class SupabaseHelper {
//   final supaClient = Supabase.instance.client;

//   void showEmailConfirmationDialog(BuildContext context, text) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(text),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }


//   // email-password sign up
//   Future<AuthResponse?> createNewUser(BuildContext context,String email, String password) async {
//     try {
//       final res = await supaClient.auth.signUp(email: email, password: password);

//       if(res.session != null)  {
//         final authBox = await Hive.openBox('auth_box');
//         String login = authBox.get('login') ??email;
//         String passwords = authBox.get('password') ?? password;

//         authBox.put('login', login);
//         authBox.put('password', passwords);
//         authBox.close();

//         final splashbox = await Hive.openBox('splash_box');
//         bool theuserisregistered = splashbox.get('theuserisregistered') ?? true;
//         splashbox.put('theuserisregistered', theuserisregistered);
//         log('${splashbox.get('firstentry')} + ${splashbox.get('theuserisregistered')}');
//         splashbox.close();
//       }else{
//         showEmailConfirmationDialog(context, 'На указанную почту отправлен код подтверждения');
//         context.maybePop();
//       }
//       return res;
//     } catch (error) {
//       log('Error during sign-in: $error');
//       if (error is AuthException && error.message == "Email not confirmed") {
//       showEmailConfirmationDialog(context, 'Подтвердите почту');
//     }

//     else if(error is AuthException && error.message == 'Email rate limit exceeded'){
//       showEmailConfirmationDialog(context, 'Превышен лимит запросов');
//     }
//       return null; 
//     }



    
//   }

//   // email-password sign in
// Future<AuthResponse?> signInExistingUser(BuildContext context, String email, String password) async {
//   try {
//     final res = await supaClient.auth.signInWithPassword(
//       email: email,
//       password: password,
//     );

//     if (res.session != null) {
//       final authBox = await Hive.openBox('auth_box');
//       String login = authBox.get('login') ?? email;
//       String passwords = authBox.get('password') ?? password;

//       authBox.put('login', login);
//       authBox.put('password', passwords);
      
//       final splashbox = await Hive.openBox('splash_box');
//       bool theuserisregistered = splashbox.get('theuserisregistered') ?? true;
//       splashbox.put('theuserisregistered', theuserisregistered);

//     }
    
//     return res;
//   } catch (error) {
//     if (error is AuthException && error.message == "Email not confirmed") {
//       showEmailConfirmationDialog(context, 'Подтвердите почту');
//     }

//     else if(error is AuthException && error.message == 'Email rate limit exceeded'){
//       showEmailConfirmationDialog(context, 'Превышен лимит запросов');
//     }
//     return null; 
//   }
// }

//   //autologin
//   Future<void> autoLogin(BuildContext context) async {
//     try {
//       final authBox = await Hive.openBox('auth_box');
//       String login = authBox.get('login') ?? '';
//      String password = authBox.get('password') ?? '';
//      authBox.close();
//     final res = await signInExistingUser(context, login, password);

//     if(res?.session != null){
//     }else{ 
//     }
//     } catch (e) {
//       log(e.toString());
//     }

    
//   }

//   // phone auth with password sign-up and verification step
//   Future<AuthResponse> createNewPhoneUser(String phone, String password) async {
//     final res = await supaClient.auth.signUp(
//       phone: phone,
//       password: password,
//     );

//     return res;
//   }

//   Future<AuthResponse> verifyPhoneUser(String phone, String token) async {
//     final res = await supaClient.auth.verifyOTP(
//       phone: phone,
//       token: token,
//       type: OtpType.sms,
//     );

//     return res;
//   }

// //sign-in phone user
//   Future<AuthResponse> signInUserWithPhone(
//       String phone, String password) async {
//     final res = await supaClient.auth.signInWithPassword(
//       phone: phone,
//       password: password,
//     );

//     return res;
//   }

//   // email magic link sign-in/up
//   Future<void> createMagicLinkUser(String email) async {
//     final res = await supaClient.auth.signInWithOtp(
//       email: email,
//     );

//     return res;
//   }

//   // social login with Google
//   Future<bool> signInWithGoogle() async {
//     final res = await supaClient.auth.signInWithOAuth(
//       OAuthProvider.google,
//     );

//     return res;
//   }

//   // sign out active user
//   Future<void> signOutActiveUser(BuildContext context) async {
//     final authBox = await Hive.openBox('auth_box');
//       authBox.put('login', '');
//       authBox.put('password', '');
//     final res = await supaClient.auth.signOut();
//     return res;
//   }

//   // sends user a reset password email, redirectTo - screen user comes back to
//   Future<void> resetExistingUserPassword(String email, String? urlPath) async {
//     final res = await supaClient.auth.resetPasswordForEmail(
//       email,
//     );

//     return res;
//   }

//   Future<UserResponse> updateUserPassword(
//       String accessToken, String password) async {
//     final res = await supaClient.auth.updateUser(
//       UserAttributes(data: {'password': password}),
//     );

//     return res;
//   }

//   // get active user
//   User? getActiveUser() {
//     final user = supaClient.auth.currentUser;

//     return user;
//   }
// }

// // A function for hashing a string in SHA-256
// String hashStringToSHA256(String input) {
//   List<int> bytes = utf8.encode(input);
//   Digest sha256Result = sha256.convert(bytes);
//   String hashString = sha256Result.toString();

//   return hashString;
// }

// // A function for converting a SHA-256 hash string back to a string
// String hashSHA256ToString(String hash) {
//   List<int> hashBytes = utf8.encode(hash);
//   String originalString = utf8.decode(hashBytes);
//   return originalString;
// }
