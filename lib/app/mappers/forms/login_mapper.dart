
import '../../../infraestructure/models/models.dart';
import '../../models/models.dart';


class LoginMapper {
  static SignInUserInput mapLoginFormDataToSignInUserInput(
          LoginFormData value) =>
      SignInUserInput(
          authMethod: value.authMethod,
          password: value.password,
          text: value.text);
}
