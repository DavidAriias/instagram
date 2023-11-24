import 'package:flutter/material.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class ConfirmAccountScreen extends StatelessWidget {
  static const name = 'confirm-account-screen';
  const ConfirmAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _ConfirmAccountView(),
    );
  }
}

class _ConfirmAccountView extends StatelessWidget {
  const _ConfirmAccountView();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomTitleText(textButton: 'Enter the confirmation code'),
          const SizedBox(height: 30),
          Text('To confirm your account, enter the verification code we sent to',
          style: textStyle.bodyLarge),
          const SizedBox(height: 20),
          CustomTextFormField(label: 'Verification Code'),
          const SizedBox(height: 15),
          CustomButton(onPressed: () {
            
          },textButton: 'Next'),
          const SizedBox(height: 15),
          CustomOutlinedButton(
            onPressed: () {
              
            },
            textButton: "I haven't received the code")
        ],
      ),
    ));
  }
}
