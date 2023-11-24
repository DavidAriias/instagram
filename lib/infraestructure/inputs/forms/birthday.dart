import 'package:formz/formz.dart';
import 'package:instagram/config/config.dart';

// Define input validation errors
enum BirthdayError { empty, ageNotPermitted }

// Extend FormzInput and provide the input type and error type.
class Birthday extends FormzInput<String, BirthdayError> {
  // Call super.pure to represent an unmodified form input.
    const Birthday.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Birthday.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == BirthdayError.empty) return 'Missing field';
    if (displayError == BirthdayError.ageNotPermitted) {
      return 'You must at least 13 years for having an account';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BirthdayError? validator(String value) {
    if (value.toString().isEmpty) return BirthdayError.empty;
    if (value.toString().trim().isEmpty) return BirthdayError.empty;
    if (DateHelper.calculateAge(DateTime.parse(value)) < 13) {
      return BirthdayError.ageNotPermitted;
    }

    return null;
  }
}
