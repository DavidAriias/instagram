import 'package:instagram/domain/entities/auth.dart';

import '../../domain/enums/auth_method.dart';
import '../enums/auth_api.dart';
import '../models/models.dart';

class AuthMapper {
  static Auth mapAuthResponseToMapEntity(AuthGraphQl response) => Auth(
      userId: response.userId,
      token: response.token,
      expiresIn: response.expiresIn,
      refreshToken: response.refreshToken,
      refreshTokenExpireIn: response.refreshTokenExpireIn,
      error: response.error);

  static String mapDomainToApi(AuthMethod authMethod) {
    switch (authMethod) {
      case AuthMethod.email:
        return ApiAuthMethod.EMAIL.name;
      case AuthMethod.phoneNumber:
        return ApiAuthMethod.PHONE_NUMBER.name;
      case AuthMethod.username:
        return ApiAuthMethod.USERNAME.name;
      case AuthMethod.id:
        return ApiAuthMethod.USER_ID.name;
    }
  }

  static Map<String, dynamic> toJson(Auth auth) => {
        'userId': auth.userId,
        'refreshToken': auth.refreshToken,
        'refreshTokenExpireIn': auth.refreshTokenExpireIn,
        'accessToken': auth.token,
        'expiresIn': auth.expiresIn,
      };

  static Auth fromJson(Map<String, dynamic> map) => Auth(
      expiresIn: map['expiresIn'],
      refreshToken: map['refreshToken'],
      refreshTokenExpireIn: map['refreshTokenExpireIn'],
      token: map['accessToken'],
      userId: map['userId']);

  static AuthInput mapAuthEntityToAuthInput(Auth auth) => AuthInput(
      token: auth.token, userId: auth.userId, refreshToken: auth.refreshToken);
}
