class AuthInput {
  final String token;
  final String refreshToken;
  final String userId;

  AuthInput({required this.token,required this.refreshToken, required this.userId});

    Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
      'token': token, 
      'userId': userId
    };
  }
}
