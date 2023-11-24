class UserMutations {
  static String changePassword = r'''
mutation($input : UpdatePasswordInput!){
  updatePassword(input: $input){
    responseTypeOfString{
      message,
      statusCode
    }
  }
}
''';

  static String changeVerified = r'''
mutation($input: UpdateIsVerificateProfileInput!){
  updateIsVerificateProfile(input: $input){
    responseTypeOfString{
      statusCode,
      message
    }
  }
}
''';

  static String changeImageProfile = r'''
mutation($input: UpdateImageProfileInput!){
  updateImageProfile(input: $input){
    responseTypeOfString{
      value,
      statusCode
    }
  }
}
''';
}
