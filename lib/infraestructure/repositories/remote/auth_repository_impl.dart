import '../../../domain/datasources/datasource.dart';
import '../../../domain/entities/auth.dart';
import '../../../domain/repositories/repositories.dart';
import '../../models/models.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<Auth> signInUser(SignInUserInput input) {
    return _dataSource.signInUser(input);
  }

  @override
  Future<Auth> checkTokenStatus(AuthInput input) {
    return _dataSource.checkAuth(input);
  }

  @override
  Future<bool> closeSession(AuthInput auth) {
    return _dataSource.closeSession(auth);
  }

  @override
  Future<String> signUpUser(SignUpUserInput input) {
    return _dataSource.signUpUser(input);
  }

  @override
  Future<String> confirmSMS(String sms) {
    return _dataSource.confirmSMS(sms);
  }

  @override
  Future<String> sendVerificationSMS(String phoneNumber) {
    return _dataSource.sendVerificationSMS(phoneNumber);
  }
}
