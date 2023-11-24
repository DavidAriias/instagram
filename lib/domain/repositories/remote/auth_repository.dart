import '../../../infraestructure/models/models.dart';
import '../../entities/auth.dart';

abstract class AuthRepository {
  Future<Auth> signInUser(SignInUserInput input);
  Future<bool> closeSession(AuthInput auth);
  Future<Auth> checkTokenStatus(AuthInput input);
  Future<String> signUpUser(SignUpUserInput input);
  Future<String> sendVerificationSMS(String phoneNumber);
  Future<String> confirmSMS(String sms);
}
