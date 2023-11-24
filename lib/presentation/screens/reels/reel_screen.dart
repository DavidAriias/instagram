import 'package:flutter/material.dart';
import '../../views/views.dart';


class ReelScreen extends StatelessWidget {
  static const String name = 'reel-screen';
  const ReelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VideoScrollableView(),
    );
  }
}

