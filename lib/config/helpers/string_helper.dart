import 'package:instagram/domain/enums/auth_method.dart';

class StringHelper {
  static bool isEmail(String text) {
    final pattern = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+');
    return pattern.hasMatch(text);
  }

  static bool isUsername(String text) {
    const minLength = 3;
    const maxLength = 30;
    final allowedCharacters = RegExp(r'^[a-zA-Z0-9_]+$');

    return text.length >= minLength &&
        text.length <= maxLength &&
        allowedCharacters.hasMatch(text);
  }

  static bool isPhoneNumber(String text) {
    final pattern = RegExp(r'^\d{10}$');
    return pattern.hasMatch(text);
  }

  static bool isValid(String texto) {
    return isEmail(texto) || isUsername(texto) || isPhoneNumber(texto);
  }

  static AuthMethod? determinateAuthMethod(String text) {
    if (isEmail(text)) {
      return AuthMethod.email;
    } else if (isPhoneNumber(text)) {
      return AuthMethod.phoneNumber;
    } else if (isUsername(text)) {
      return AuthMethod.username;
    }
    return null;
  }
}
