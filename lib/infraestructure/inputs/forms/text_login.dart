import 'package:formz/formz.dart';

import '../../../config/config.dart';

// Define input validation errors
enum TextWayLoginError { empty, length, inputNotAllowed }

// Extend FormzInput and provide the input type and error type.
class TextWayLogin extends FormzInput<String, TextWayLoginError> {
  // Call super.pure to represent an unmodified form input.
  const TextWayLogin.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextWayLogin.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextWayLoginError.empty) return 'Missing field';
    if (displayError == TextWayLoginError.inputNotAllowed) return 'Input must be email, username or phone number';
    if (displayError == TextWayLoginError.length) return 'Length must be at least 2 characters and not exceed 30 characters';

    return null;
  } // Override validator to handle validating a given input value.

  @override
  TextWayLoginError? validator(String value) {
    if (value.isEmpty) return TextWayLoginError.empty;
    if (value.trim().isEmpty) return TextWayLoginError.empty;
    if (value.length < 2) return TextWayLoginError.length;
    if (value.length > 30) return TextWayLoginError.length;
    if (!StringHelper.isValid(value)) return TextWayLoginError.inputNotAllowed;

    return null;
  }
}
