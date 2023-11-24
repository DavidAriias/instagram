import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram/presentation/widgets/widgets.dart';

class EditFieldScreen extends StatelessWidget {
  static const String name = 'edit-field-screen';
  const EditFieldScreen({super.key, required this.fieldName});

  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _EditFieldView(fieldName: fieldName),
    );
  }
}

class _EditFieldView extends StatelessWidget {
  const _EditFieldView({
    required this.fieldName,
  });

  final String fieldName;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        CustomAppBar(
          centerTitle: true,
          title: Text(fieldName.toUpperCase(),
              style:
                  textStyle.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
          leadingWidth: 56,
          padding: const EdgeInsets.all(0),
          leading: CustomIconCupertinoButton(
              onPressed: () => context.pop(),
              child: Icon(Icons.arrow_back_ios_new, color: iconColor)),
          pinned: true,
        ),
      ],
    );
  }
}
