class SmsMutations {
  static String sendSMS = r'''
mutation($input: SendVerificationSMSInput!){
  sendVerificationSMS(input: $input){
    smsType{
      ...smsFragment
    }
  }
}
''';
  static String confirmSMS = r'''
mutation($input: ConfirmSMSCodeInput!){
  confirmSMSCode(input: $input){
    smsType{
      ...smsFragment
    }
  }
}
  ''';
}
