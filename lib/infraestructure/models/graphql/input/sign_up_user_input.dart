import '../../../enums/auth_api.dart';

class SignUpUserInput {
  final String birthday;
  final String? email;
  final String? imageProfile;
  final String? name;
  final String password;
  final String? phoneNumber;
  final ApiPronouns? pronoun;
  final String username;

  SignUpUserInput(
      {required this.birthday,
      required this.email,
      required this.imageProfile,
      required this.name,
      required this.password,
      required this.phoneNumber,
      required this.pronoun,
      required this.username});

  Map<String, dynamic> toJson() {
    return {
      "user": {
        "birthday": birthday,
        "email": email,
        "imageProfile": imageProfile,
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "pronoun": pronoun,
        "username": username
      }
    };
  }
}
