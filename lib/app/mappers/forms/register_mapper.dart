import 'package:instagram/app/models/models.dart';
import 'package:instagram/infraestructure/models/models.dart';

class RegisterMapper {
  static SignUpUserInput mapRegisterFormDataToSignUpUserInput(
          RegisterFormData value) =>
      SignUpUserInput(
          birthday: value.birthday,
          email: value.email,
          imageProfile: value.imageProfile?.path,
          name: value.fullName,
          password: value.password,
          phoneNumber: value.phoneNumber,
          pronoun: null,
          username: value.username);
}
