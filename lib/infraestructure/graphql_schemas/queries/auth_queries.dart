
class AuthQueries{
   static String checkStatusQuery = r'''
query($authType: AuthTypeInInput!){
    checkTokenStatus(authType: $authType){
      userId,
      token,
      expiresIn,
       refreshToken,
       refreshTokenExpireIn,
       error 
    }
}
'''; 
}