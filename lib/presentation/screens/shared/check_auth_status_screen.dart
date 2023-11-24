import 'package:flutter/material.dart';


class CheckAuthStatusScreen extends StatelessWidget {
  static const String name = 'check-auth-status-screen';
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
