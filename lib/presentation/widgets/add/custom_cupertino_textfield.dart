import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTextField extends StatelessWidget {
  const CustomCupertinoTextField(
      {super.key,
      this.prefix,
      this.suffix,
      this.placeholder,
      this.onChanged,
      this.readOnly = false,
      this.onTap, this.initialText});

  final Widget? prefix;
  final Widget? suffix;
  final String? placeholder;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final String? initialText;

  @override
  Widget build(BuildContext context) {
    final backgroundColorDevice = Theme.of(context).colorScheme.background;
    final textStyle = Theme.of(context).textTheme;
    final TextEditingController controller =
        TextEditingController(text: initialText);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CupertinoTextField(
        controller: controller,
        style: textStyle.bodyMedium,
        readOnly: readOnly,
        onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
        onTap: onTap,
        onChanged: onChanged,
        padding: const EdgeInsets.all(10),
        placeholder: placeholder,
        placeholderStyle: textStyle.titleMedium?.copyWith(color: Colors.grey),
        decoration: BoxDecoration(color: backgroundColorDevice),
        prefix: prefix,
        suffix: suffix,
      ),
    );
  }
}
