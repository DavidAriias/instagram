class AuthFragments {
  static String tokenInfoFragment = r'''
  fragment ResponseAuth on AuthTypeOut {
        userId
        token
        expiresIn
        refreshToken
        refreshTokenExpireIn
        error
  }
''';
}
