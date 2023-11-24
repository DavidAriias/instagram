import 'package:instagram/domain/entities/auth.dart';
import '../../../infraestructure/models/models.dart';

abstract class AuthDataSource {
  Future<Auth> signInUser(SignInUserInput input);
  Future<Auth> checkAuth(AuthInput input);
  Future<bool> closeSession(AuthInput auth);
  Future<String> signUpUser(SignUpUserInput input);
  Future<String> sendVerificationSMS(String phoneNumber);
  Future<String> confirmSMS(String sms);
}
