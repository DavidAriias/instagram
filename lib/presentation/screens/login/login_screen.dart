import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/constants/assets_consts.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login-screen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginView(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _LoginView extends ConsumerWidget {
  const _LoginView();

  void showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    ref.read(mainUserProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    final textColor = Theme.of(context).textTheme.displayLarge?.decorationColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsConsts.instagramLogo,
                  width: 250, height: 120, color: textColor),
              Divider(color: textColor?.withOpacity(0.1)),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: "Phone number, username or email address",
                onChanged: ref.read(loginFormProvider.notifier).onTextChange,
                errorText:
                    loginForm.isFormPosted ? loginForm.text.errorMessage : null,
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: "Password",
                obscureText: true,
                onChanged:
                    ref.read(loginFormProvider.notifier).onPasswordChange,
                errorText: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
              ),
              const SizedBox(height: 15),
              CustomButton(
                  textButton: "Log In",
                  onPressed: loginForm.isPosting
                      ? null
                      : ref.read(loginFormProvider.notifier).onFormSubmit),
              const SizedBox(height: 5),
              CustomTextButton(
                onPressed: () {
                  ref.read(loginFormProvider.notifier).onResetForm();
                  context.push('/pass');
                },
                textButton: "Forget your password?",
              ),
              const SizedBox(height: 50),
              const _SignUpRow(),
              Image.asset(AssetsConsts.metaLogo, width: 120, color: textColor)
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpRow extends ConsumerWidget {
  const _SignUpRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?", style: textStyle.bodyLarge),
        CustomTextButton(
            onPressed: () {
              ref.read(loginFormProvider.notifier).onResetForm();
              context.push('/register');
            },
            textButton: "Sign Up")
      ],
    );
  }
}
