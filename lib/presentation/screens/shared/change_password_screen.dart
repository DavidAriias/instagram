import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String name = 'change-password-screen';
  static const String forgetPasswordName = 'forget-screen';
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatelessWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    final textStyle = Theme.of(context).textTheme;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          padding: const EdgeInsets.all(0),
          leadingWidth: 56,
          leading: CustomIconCupertinoButton(
              onPressed: () => context.pop(),
              child: Icon(Icons.arrow_back_ios_new, color: iconColor)),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Change password',
                    style: textStyle.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                Text(
                    'Your password must be at least 6 characters and should include a combination of numbers, letters, and special characters (!&@%)',
                    style: textStyle.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 30),
                CustomTextFormField(
                  obscureText: true,
                  label: 'New password',
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  obscureText: true,
                  label: 'Re-type new password',
                ),
                const SizedBox(height: 30),
                CustomButton(textButton: 'Change password', onPressed: () {})
              ],
            ),
          ),
        )
      ],
    );
  }
}
