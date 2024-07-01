import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: const Text(
          'Performance',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(13, 154, 189, 0.15),
        ),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(15, 5, 158, 0.4),
                  blurRadius: 5.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    3.0, // Move to right 5  horizontally
                    3.0, // Move to bottom 5 Vertically
                  ),
                ),
              ]),
          child: const Column(
            children: [
              // Container(
              //   height: 15,
              //   decoration: const BoxDecoration(
              //       border: Border(
              //           bottom: BorderSide(
              //               color: Color.fromRGBO(13, 154, 189, 0.5), width: 2))),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class InwardDetails {
  InwardDetails(this.feild, this.detail);
  final String feild;
  final String detail;
}
