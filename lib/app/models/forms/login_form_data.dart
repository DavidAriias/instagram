import 'package:instagram/domain/enums/auth_method.dart';

class LoginFormData {
  final String text;
  final String password;
  final AuthMethod authMethod;

  LoginFormData({
    required this.text,
    required this.password,
    required this.authMethod});
  
}
