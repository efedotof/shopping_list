
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());


  // void createAccountSupaBase(BuildContext context, String email, String password, String repitPassword){
  //   if(password == repitPassword){
  //     emit(IsLoading());
  //     SupabaseHelper supabaseHelper = SupabaseHelper();
  //     supabaseHelper.createNewUser(context, email, password);
  //     emit(IsRegistration());
  //   }else{
  //     showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text("Пароли не совпадают"),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: const Text("Назад"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   }
   
  // }

  // void signInUserSupaBase(BuildContext context, String email, String password){
  //   emit(IsLoading());
  //   SupabaseHelper supabaseHelper = SupabaseHelper();
  //   supabaseHelper.signInExistingUser(context, email, password);
  //   if(supabaseHelper.getActiveUser() != null){
  //     context.maybePop();
  //   }
  //   emit(IsAuth());
  // }
}
