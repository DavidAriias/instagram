import 'package:formz/formz.dart';

// Define input validation errors
enum FullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class FullName extends FormzInput<String, FullNameError> {
  // Call super.pure to represent an unmodified form input.
  const FullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const FullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == FullNameError.empty) return 'Missing field';

    return null;  
  }

  // Override validator to handle validating a given input value.
  @override
  FullNameError? validator(String value) {
    if (value.isEmpty) return FullNameError.empty;
    if (value.trim().isEmpty) return FullNameError.empty;
    return null;
  }
}
