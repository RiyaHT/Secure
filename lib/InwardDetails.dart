import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InwardDetailsScreen extends StatefulWidget {
  const InwardDetailsScreen({super.key});

  @override
  State<InwardDetailsScreen> createState() => _InwardDetailsScreenState();
}

class _InwardDetailsScreenState extends State<InwardDetailsScreen> {
  List<InwardDetails> inwardDetail = [
    InwardDetails('Inward Type:', 'Proposal'),
    InwardDetails('Proposal Type:', 'Renewal'),
    InwardDetails('Product Name:',
        'Loan Insurance try try try try try try try try try try'),
    InwardDetails('Inward Type:', 'Proposal'),
    InwardDetails('Proposal Type:', 'Renewal'),
    InwardDetails('Product Name:', 'Loan Insurance'),
    InwardDetails('Inward Type:', 'Proposal'),
    InwardDetails('Proposal Type:', 'Renewal'),
    InwardDetails('Product Name:', 'Loan Insurance')
  ];
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
          'Inward No: 1234567',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(13, 154, 189, 0.08),
        ),
        child: Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromRGBO(13, 154, 189, 0.7), width: 2),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              // Container(
              //   height: 15,
              //   decoration: const BoxDecoration(
              //       border: Border(
              //           bottom: BorderSide(
              //               color: Color.fromRGBO(13, 154, 189, 0.5), width: 2))),
              // ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: inwardDetail.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromRGBO(13, 154, 189, 0.3),
                                    width: 2))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Text(
                                '${inwardDetail[index].feild} ',
                                softWrap: false,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Wrap(
                                children: [
                                  Text(
                                    '${inwardDetail[index].detail} ',
                                    maxLines: 5,
                                    softWrap: false,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Scroll for more details ',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.arrow_downward, size: 14, color: Colors.black),
              ])
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
