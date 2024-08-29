import 'package:hive_flutter/hive_flutter.dart';

part 'authsbox.g.dart';

@HiveType(typeId: 1)
class AuthBox extends HiveObject {

  @HiveField(0)
  String login;

  @HiveField(1)
  String password;

  AuthBox({
    this.login = '',
    this.password = '',
  });
}