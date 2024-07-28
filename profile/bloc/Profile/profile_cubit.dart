import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spisok_pokupok/localStorage/LisBoxses/list_box.dart';
import 'package:spisok_pokupok/localStorage/favoritBoxses/favorit_box_receptor.dart';




part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.context}) : super(ProfileInitial()){
    // checkForUser(context);
  }

  final BuildContext context;

  // void checkForUser(BuildContext context) async{
  //   SupabaseHelper supabaseHelper = SupabaseHelper();
  //   supabaseHelper.autoLogin(context);

  //   log(supabaseHelper.getActiveUser().toString());

  //   if(supabaseHelper.getActiveUser() == null){
  //     emit(UserIsNotAuth());
  //   }else{
  //     emit(UserIsAuth());
  //   }
  // }

  // void exitSupaBase(BuildContext context) async {
  //   // final _authBox = await Hive.openBox('auth_box');
  //   SupabaseHelper supabaseHelper = SupabaseHelper();
  //   supabaseHelper.signOutActiveUser(context);
  //   checkForUser(context);
  //   emit(UserIsNotAuth());
    

  // }


  // void authUserShow(BuildContext context) async{
  //   showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //       ),
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return const SignInOptionsScreen();
  //       },
  //     );
  //     checkForUser(context);
  // }


  // void createAccount( BuildContext context ){
  //   context.maybePop();
  //    showModalBottomSheet(
  //       context: context,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
  //       ),
  //       isScrollControlled: true,
  //       builder: (context) {
  //         return const SignInOptionsScreenReg();
  //       },
  //     );
  //     checkForUser(context);
  // }

  //  void createLogin( BuildContext context ){
  //   context.maybePop();
  //   checkForUser(context);
  // }



  void clearAppCash(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Подтвердите удаление"),
          content: const Text("Вы уверены, что хотите удалить этот элемент?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Отмена"),
            ),
            TextButton(
              onPressed: () => _showDialogClear(context),
              child: const Text("Удалить"),
            ),
          ],
        );
      },
    );

  }

  void _showDialogClear(BuildContext context) {
    final boxList = Hive.box<ListBox>('listbox');
    var boxRep = Hive.box<Favoritboxreceptor>('favorit_recip');

    boxList.clear();
    boxRep.clear();

    Navigator.of(context).pop(false);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Удалено'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
