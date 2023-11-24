import 'package:instagram/domain/enums/auth_method.dart';
import 'package:instagram/infraestructure/mappers/auth_mapper.dart';

class SignInUserInput {
  final AuthMethod authMethod;
  final String password;
  final String text;

  SignInUserInput(
      {required this.authMethod, required this.password, required this.text});

  Map<String, dynamic> toJson() {
    return {
      'authMethod': AuthMapper.mapDomainToApi(authMethod), 
      'password': password,
      'stringForMethod': text,
    };
  }
}
