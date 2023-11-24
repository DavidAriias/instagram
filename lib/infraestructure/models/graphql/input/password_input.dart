class PasswordInput {
  final String password;
  final String accessToken;
  final String userId;

  PasswordInput({required this.password, required this.accessToken, required this.userId});

    Map<String, dynamic> toJson() {
    return {
     'password': password,
     'userId': userId
    };
  }
}
