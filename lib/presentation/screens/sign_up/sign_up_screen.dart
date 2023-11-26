import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/config/constants/assets_consts.dart';
import 'package:instagram/config/dependenciesInjection/instances_container.dart';
import 'package:instagram/presentation/providers/providers.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  static const name = 'sign-up-screen';

  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SignUpView(),
      resizeToAvoidBottomInset: false,
    );
  }
}

class _SignUpView extends ConsumerWidget {
  const _SignUpView();

  void showSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

    final textColor = Theme.of(context).textTheme.displayLarge?.decorationColor;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsConsts.instagramLogo,
                  width: 250,
                  height: 100,
                  color: textColor,
                ),
                const SizedBox(height: 5),
                const _ImageProfileButton(),
                const SizedBox(height: 30),
                CustomTextFormField(
                  label: 'Phone number or email address',
                  onChanged:
                      ref.read(registerFormProvider.notifier).onTextChange,
                  errorText: registerForm.isFormPosted
                      ? registerForm.text.errorMessage
                      : null,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'Full name',
                  onChanged:
                      ref.read(registerFormProvider.notifier).onFullnameChange,
                  errorText: registerForm.isFormPosted
                      ? registerForm.fullName.errorMessage
                      : null,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'Username',
                  onChanged:
                      ref.read(registerFormProvider.notifier).onUsernameChange,
                  errorText: registerForm.isFormPosted
                      ? registerForm.username.errorMessage
                      : null,
                ),
                const SizedBox(height: 15),
                CustomTextFormField(
                  label: 'Password',
                  obscureText: true,
                  onChanged:
                      ref.read(registerFormProvider.notifier).onPasswordChange,
                  errorText: registerForm.isFormPosted
                      ? registerForm.password.errorMessage
                      : null,
                ),
                const SizedBox(height: 15),
                DatePickerField(
                  onChanged:
                      ref.read(registerFormProvider.notifier).onBirthdayChange,
                  errorText: registerForm.isFormPosted
                      ? registerForm.birthday.errorMessage
                      : null,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  textButton: 'Sign Up',
                  onPressed: registerForm.isPosting
                      ? null
                      : ref.read(registerFormProvider.notifier).onSendSMS,
                ),
                const SizedBox(height: 20),
                CustomTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  textButton: 'Already have you account?',
                ),
                Image.asset(AssetsConsts.metaLogo,
                    width: 120, color: textColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageProfileButton extends ConsumerWidget {
  const _ImageProfileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageProvider = ref.watch(registerFormProvider).imageProfile;
    return GestureDetector(
      onTap: () async {
        final photo = await cameraService.selectPhoto();
        ref.read(registerFormProvider.notifier).onSelectPhoto(photo);
      },
      child: Stack(
        children: [
          UserAvatarWithoutGradient(
            radius: 40,
            image: imageProvider?.path,
          ),
          Positioned(
            bottom: -2,
            left: 70,
            child: Icon(Icons.add_a_photo, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
