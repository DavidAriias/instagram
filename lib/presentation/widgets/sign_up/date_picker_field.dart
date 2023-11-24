import 'package:flutter/material.dart';
import 'package:instagram/config/helpers/date_helper.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key, this.onChanged, this.errorText});

  final void Function(DateTime)? onChanged;
  final String? errorText;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${DateHelper.formatDate(picked)} (${DateHelper.calculateAge(picked)} years)';
      });

      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    final errorInputBorder =
        inputBorder.copyWith(borderSide: const BorderSide(color: Colors.red));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _dateController,
            readOnly: true,
            onTap: () {
              FocusScope.of(context)
                  .requestFocus(FocusNode()); // Ocultar el teclado
              _selectDate(context); // Mostrar el DatePicker
            },
            decoration: InputDecoration(
              errorBorder: errorInputBorder,
              focusedErrorBorder: errorInputBorder,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: textStyle.labelLarge?.fontSize,
                  fontStyle: textStyle.labelLarge?.fontStyle),
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              filled: true,
              contentPadding: const EdgeInsets.all(8),
              label: const Text('Birthday'),
              labelStyle: textStyle.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
