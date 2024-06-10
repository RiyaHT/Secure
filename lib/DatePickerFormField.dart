import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final String labelText;
  final String date;

  final Function(DateTime?) onChanged;

  DatePickerFormField({
    Key? key,
    required this.labelText,
    required this.date,
    required this.onChanged,
  }) : super(key: key ?? ObjectKey(DateTime.now()));

  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onChanged(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const OutlineInputBorder(
              borderSide: const BorderSide(
            color: Color.fromRGBO(11, 133, 163, 1),
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              widget.date,
            ),
            const Icon(
              Icons.calendar_today,
              color: Color.fromRGBO(11, 133, 163, 1),
            ),
          ],
        ),
      ),
    );
  }
}
