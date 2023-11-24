import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:instagram/app/models/models.dart';
import 'package:instagram/infraestructure/inputs/inputs.dart';
import 'package:instagram/presentation/enums/enums.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../../config/config.dart';
import '../../../domain/enums/auth_method.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormNotifier(registerUserCallback);
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(RegisterFormData) registerUserCallback;
  RegisterFormNotifier(this.registerUserCallback) : super(RegisterFormState());

  void onResetForm() {
    state =
        state.copyWith(isPosting: false, isValid: false, isFormPosted: false);
  }

  void onSelectPhoto(String? value) {
    state = state.copyWith(imageProfile: value);
  }

  void onTextChange(String value) {
    final newText = TextWayRegister.dirty(value);

    state = state.copyWith(
        text: newText, isValid: Formz.validate([newText, state.text]));
  }

  void onFullnameChange(String value) {
    final newFullname = FullName.dirty(value);

    state = state.copyWith(
        fullName: newFullname,
        isValid: Formz.validate([newFullname, state.fullName]));
  }

  void onUsernameChange(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(username: newUsername);
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.password]));
  }

  void onBirthdayChange(DateTime value) {
    final newBirthday = Birthday.dirty(value.toString());
    state = state.copyWith(
        birthday: newBirthday,
        isValid: Formz.validate([newBirthday, state.birthday]));
  }

  void onSendSMS() {
    state = state.copyWith(registerStatus: RegisterStatus.validating);
    print(state.toString());
  }

  void onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    await registerUserCallback(RegisterFormData(
        imageProfile: state.imageProfile,
        email: (state.authMethod == AuthMethod.email) ? state.text.value : null,
        phoneNumber: (state.authMethod == AuthMethod.phoneNumber)
            ? state.text.value
            : null,
        fullName: state.fullName.value,
        password: state.password.value,
        birthday: state.birthday.value,
        username: state.username.value));

    state = state.copyWith(isPosting: true);

    onResetForm();
  }

  void _touchEveryField() {
    final text = TextWayRegister.dirty(state.text.value);
    final fullName = FullName.dirty(state.fullName.value);
    final password = Password.dirty(state.password.value);
    final birthday = Birthday.dirty(state.birthday.value);
    final username = Username.dirty(state.username.value);
    final authMethod = StringHelper.determinateAuthMethod(state.text.value);

    state = state.copyWith(
      isFormPosted: true,
      text: text,
      fullName: fullName,
      password: password,
      birthday: birthday,
      imageProfile: state.imageProfile,
      username: username,
      authMethod: authMethod,
    );
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final TextWayRegister text;
  final Password password;
  final Birthday birthday;
  final FullName fullName;
  final String? imageProfile;
  final Username username;
  final AuthMethod authMethod;
  final RegisterStatus registerStatus;

  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.text = const TextWayRegister.pure(),
      this.password = const Password.pure(),
      this.birthday = const Birthday.pure(),
      this.fullName = const FullName.pure(),
      this.imageProfile,
      this.username = const Username.pure(),
      this.authMethod = AuthMethod.email,
      this.registerStatus = RegisterStatus.defaultStatus});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          TextWayRegister? text,
          Password? password,
          Birthday? birthday,
          FullName? fullName,
          String? imageProfile,
          Username? username,
          AuthMethod? authMethod,
          RegisterStatus? registerStatus}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          text: text ?? this.text,
          password: password ?? this.password,
          birthday: birthday ?? this.birthday,
          fullName: fullName ?? this.fullName,
          imageProfile: imageProfile ?? this.imageProfile,
          username: username ?? this.username,
          authMethod: authMethod ?? this.authMethod,
          registerStatus: registerStatus ?? this.registerStatus);

  @override
  String toString() {
    return '''
      RegisterFormState: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      text: $text,
      password: $password,
      birthday: $birthday,
      fullName: $fullName,
      username: $username,
      imageProfile: $imageProfile,
      authMethod: $authMethod,
      registerStatus: $registerStatus
    ''';
  }
}
