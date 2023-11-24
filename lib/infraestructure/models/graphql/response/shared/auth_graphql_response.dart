class AuthGraphQl {
    final String userId;
    final String token;
    final int expiresIn;
    final String refreshToken;
    final int refreshTokenExpireIn;
    final String? error;

    AuthGraphQl({
        required this.userId,
        required this.token,
        required this.expiresIn,
        required this.refreshToken,
        required this.refreshTokenExpireIn,
        required this.error,
    });

    factory AuthGraphQl.fromJson(Map<String, dynamic> json) => AuthGraphQl(
        userId: json["userId"],
        token: json["token"],
        expiresIn: json["expiresIn"],
        refreshToken: json["refreshToken"],
        refreshTokenExpireIn: json["refreshTokenExpireIn"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "token": token,
        "expiresIn": expiresIn,
        "refreshToken": refreshToken,
        "refreshTokenExpireIn": refreshTokenExpireIn,
        "error": error,
    };
}
