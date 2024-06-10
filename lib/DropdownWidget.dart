import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final value;
  final String hintText;
  final onChanged;
  final String label;

  DropdownWidget(
      {required this.items,
      required this.hintText,
      this.value = '',
      this.onChanged,
      this.label = ''});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,

      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(13, 154, 189, 1),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        focusColor: const Color.fromRGBO(13, 154, 189, 1),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(13, 154, 189, 1), width: 2),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(13, 154, 189, 1), width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
      hint: Text(
        widget.hintText,
        style: const TextStyle(fontSize: 12),
      ),

      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return '  Please Select ${widget.label}';
        }
        return null;
      },
      onChanged: widget.onChanged,

      // (value) {
      //   selectedBranch = value;
      // },
      onSaved: (value) {},
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
        iconEnabledColor: const Color.fromRGBO(13, 154, 189, 1),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      value: widget.value,
    );
  }
}
