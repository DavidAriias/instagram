class AuthMutations {
  static String loginMutation = r'''
mutation($input : SignInUserInput!){
    signInUser(input: $input){
        authTypeOut{
            userId
            token
            expiresIn
            refreshToken
            refreshTokenExpireIn
            error
        }
    }
}
  ''';

  static String signUpMutation = r'''
mutation($input : SignUpUserInput!){
    signUpUser(input: $input){
      responseTypeOfString{
        value
        statusCode
        message
      }
    }
  }
  ''';

  static String closeSession = r'''
mutation($input:CloseSessionInput!){
    closeSession(input: $input){
        responseTypeOfString{
            statusCode,
            message
        }
    }
}
''';
}
