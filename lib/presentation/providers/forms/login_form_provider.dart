import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:instagram/domain/enums/auth_method.dart';
import 'package:instagram/infraestructure/inputs/inputs.dart';
import 'package:instagram/presentation/providers/providers.dart';

import '../../../app/models/models.dart';
import '../../../config/config.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  final getProfileCallback =
      ref.watch(mainUserProvider.notifier).getDetailsMainProfile;

  return LoginFormNotifier(loginUserCallback, getProfileCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(LoginFormData) loginUserCallback;
  final Function() getProfileCallback;

  LoginFormNotifier(this.loginUserCallback, this.getProfileCallback)
      : super(LoginFormState());

  void onResetForm() {
    state = state.copyWith(
        isPosting: false,
        isValid: false,
        password: const Password.pure(),
        text: const TextWayLogin.pure(),
        isFormPosted: false);
  }

  void onTextChange(String value) {
    final newText = TextWayLogin.dirty(value);
    state = state.copyWith(
        text: newText, isValid: Formz.validate([newText, state.text]));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.password]));
  }

  void onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    await loginUserCallback(LoginFormData(
        text: state.text.value,
        password: state.password.value,
        authMethod: state.authMethod));

  }

  void _touchEveryField() {
    final text = TextWayLogin.dirty(state.text.value);
    final password = Password.dirty(state.password.value);
    final authMethod = StringHelper.determinateAuthMethod(state.text.value);

    state = state.copyWith(
        isFormPosted: true,
        text: text,
        password: password,
        authMethod: authMethod,
        isValid: Formz.validate([text, password]));
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final TextWayLogin text;
  final Password password;
  final AuthMethod authMethod;

  LoginFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.text = const TextWayLogin.pure(),
      this.password = const Password.pure(),
      this.authMethod = AuthMethod.email});

  LoginFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          TextWayLogin? text,
          Password? password,
          AuthMethod? authMethod}) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          text: text ?? this.text,
          password: password ?? this.password,
          authMethod: authMethod ?? this.authMethod);

  @override
  String toString() {
    return '''
      LoginFormState: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      text: $text,
      password: $password,
      authMethod: $authMethod
    ''';
  }
}
