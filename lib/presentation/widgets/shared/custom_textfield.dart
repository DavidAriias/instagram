import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.hintTextInput = "",
      this.obscureText = false,
      this.label = "",
      this.onChanged,
      this.validator,
      this.errorText,
      this.controller});

  final String hintTextInput;
  final bool obscureText;
  final String label;
  final String? errorText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    final errorInputBorder = inputBorder.copyWith(borderSide: const BorderSide(color: Colors.red));

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorBorder: errorInputBorder,
        focusedErrorBorder: errorInputBorder,
        errorText: errorText,
        errorStyle: TextStyle(
          color: Colors.red, 
          fontSize: textStyle.labelLarge?.fontSize,
          fontStyle: textStyle.labelLarge?.fontStyle),
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          hintText: hintTextInput,
          label: Text(label),
          labelStyle: textStyle.bodyMedium),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
    );
  }
}
