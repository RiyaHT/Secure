import 'package:flutter/material.dart';

class CustomInputContainer extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const CustomInputContainer({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(13, 154, 189, 0.08),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Text(
                '${title!}:',
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(13, 154, 189, 1),
                ),
              ),
              const SizedBox(height: 10),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}
