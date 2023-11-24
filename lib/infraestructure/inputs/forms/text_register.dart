import 'package:formz/formz.dart';

import '../../../config/config.dart';

// Define input validation errors
enum TextWayRegisterError { empty, length, inputNotAllowed }

// Extend FormzInput and provide the input type and error type.
class TextWayRegister extends FormzInput<String, TextWayRegisterError> {
  // Call super.pure to represent an unmodified form input.
  const TextWayRegister.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const TextWayRegister.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TextWayRegisterError.empty) return 'Missing field';
    if (displayError == TextWayRegisterError.inputNotAllowed) return 'Input must be email or phone number';
    if (displayError == TextWayRegisterError.length) return 'Length must be at least 2 characters and not exceed 30 characters';

    return null;
  } // Override validator to handle validating a given input value.

  @override
  TextWayRegisterError? validator(String value) {
    if (value.isEmpty) return TextWayRegisterError.empty;
    if (value.trim().isEmpty) return TextWayRegisterError.empty;
    if (value.length < 2) return TextWayRegisterError.length;
    if (value.length > 30) return TextWayRegisterError.length;
    if (StringHelper.isUsername(value)) return TextWayRegisterError.inputNotAllowed;

    return null;
  }
}
