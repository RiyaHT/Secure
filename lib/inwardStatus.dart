import 'package:flutter/material.dart';
import 'package:secure_app/inwardForm%201.dart';

class InwardStatus extends StatefulWidget {
  const InwardStatus({super.key});

  @override
  State<InwardStatus> createState() => _InwardStatusState();
}

class _InwardStatusState extends State<InwardStatus> {
  final _controller = SearchController();
  List<Employee> employees = <Employee>[
    Employee(1172943, 'Test New', 26166, 'Private Car 4W', 1000, 'Proposal',
        '25/02/2024', 'Proposal Sourced'),
    Employee(1176479, 'Test Created', 26166, 'Car Insurance', 2000, 'Proposal',
        '14/02/2024', 'Declined'),
    Employee(1172333, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Proposal Sourced'),
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
          'Inward Status',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(13, 154, 189, 1),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.01,
              // ),
              Container(
                width: MediaQuery.of(context).size.width * 0.72,
                height: MediaQuery.of(context).size.height * 0.06,
                child: SearchBar(
                    controller: _controller,
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set border radius for rectangular shape
                      ),
                    ),
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 15.0)),
                    hintText: 'Inward No/Customer Name',
                    elevation: const MaterialStatePropertyAll(10),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 243, 242, 242)),
                    onTap: () {
                      _controller.openView();
                    },
                    onChanged: (_) {
                      _controller.openView();
                    },
                    trailing: <Widget>[
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(10, 111, 136, 1),
                          ))
                    ]),
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.01,
              // ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.22,
                // margin: EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 243, 242, 242)),
                        shadowColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(15, 5, 158, 0.4)),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set border radius for rectangular shape
                          ),
                        )),
                    onPressed: () {
                      Navigator.of(context).push(_createRoute(MyForm()));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MyForm()),
                      // );
                    },
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_add,
                          color: Color.fromRGBO(10, 111, 136, 1),
                          size: 16,
                        ),
                        Wrap(children: [
                          Text('Add Inward',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(10, 111, 136, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8)),
                        ])
                      ],
                    )),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Color.fromRGBO(13, 154, 189, 1),
                              width: 2)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Inward Number: ${employees[index].inwardNo} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Customer Name: ${employees[index].name} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 0.8,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Agreement Code: ${employees[index].code} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 0.8,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Product: ${employees[index].product} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 0.8,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Premium Amount: ${employees[index].amount} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        letterSpacing: 0.8,
                                        fontSize: 11,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Form Type: ${employees[index].type} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        letterSpacing: 0.8,
                                        fontSize: 11,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Date: ${employees[index].date} ',
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        letterSpacing: 0.8,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                        color: (employees[index].status ==
                                                'Declined')
                                            ? Colors.red
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        ' ${employees[index].status} ',
                                        softWrap: false,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ]),
                          ]));
                }),
          )
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(1172943, 'Test New', 26166, 'Private Car 4W', 1000, 'Proposal',
          '25/02/2024', 'Proposal Sourced'),
      Employee(1176479, 'Test Created', 26166, 'Group Health Insurance', 2000,
          'Proposal', '14/02/2024', 'Declined'),
      Employee(1172333, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
          '12/02/2024', 'Proposal Sourced'),
    ];
  }
}

class Employee {
  Employee(this.inwardNo, this.name, this.code, this.product, this.amount,
      this.type, this.date, this.status);
  final int inwardNo;
  final String name;
  final int code;
  final String product;
  final int amount;
  final String type;
  final String date;
  final String status;
}

Route _createRoute(screenName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screenName,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);

      var end = Offset.zero;

      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
