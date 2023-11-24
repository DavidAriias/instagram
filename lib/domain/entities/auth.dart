class Auth {
  String userId;
  final String token;
  final int expiresIn;
  final String refreshToken;
  final int refreshTokenExpireIn;
  final String? error;

  Auth({
    required this.userId,
    required this.token,
    required this.expiresIn,
    required this.refreshToken,
    required this.refreshTokenExpireIn,
    this.error
  });
  
}
