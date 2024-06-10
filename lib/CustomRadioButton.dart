import 'package:flutter/material.dart';
import 'package:secure_app/commonFunction.dart';

class CustomRadioButton extends StatefulWidget {
  final String text;
  final List<String> options;
  String? groupValue;
  final Function onChanged;
  CustomRadioButton({
    super.key,
    required this.text,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text(
                '${widget.text}:',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(13, 154, 189, 1),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Wrap(
              spacing: 15,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.options.map((option) {
                return Row(
                  children: [
                    Radio(
                      activeColor: const Color.fromRGBO(13, 154, 189, 1),
                      value: option,
                      groupValue: widget.groupValue,
                      onChanged: (value) {
                        widget.onChanged(value);
                        setState(() {
                          widget.groupValue = value;
                        });
                      },
                    ),
                    Text(option),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
