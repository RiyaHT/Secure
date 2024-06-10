import 'package:flutter/material.dart';
import 'package:secure_app/dashboard.dart';
import 'package:secure_app/inwardForm%201.dart';
import 'package:secure_app/login.dart';

class InwardStatus2 extends StatefulWidget {
  const InwardStatus2({super.key});

  @override
  State<InwardStatus2> createState() => _InwardStatus2State();
}

class _InwardStatus2State extends State<InwardStatus2> {
  int _currentIndex1 = 0;
  var widgetArray = [];
  bool _isSearching = false;
  final _controller = SearchController();
  List<Employee> employees = <Employee>[
    Employee(1172943, 'Test New', 26166, 'Private Car 4W', 1000, 'Proposal',
        '25/02/2024', 'Proposal Sourced'),
    Employee(1176479, 'Test Created', 26166, 'Car Insurance', 2000, 'Proposal',
        '14/02/2024', 'Declined'),
    Employee(1172333, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Proposal Sourced'),
    Employee(1172337, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Discrepency'),
    Employee(1172332, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Completed'),
    Employee(1172336, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Discrepency'),
    Employee(1172338, 'Test ', 26166, 'Private Car 4W', 1000, 'Proposal',
        '12/02/2024', 'Completed'),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      widgetArray = [];
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Employee> _searchResult = [];

  void _search(String query) {
    _searchResult.clear();
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
      });
      return;
    }
    final String lowerCaseQuery = query.toLowerCase();
    _searchResult = employees.where((item) {
      return item.inwardNo.toString().toLowerCase().contains(lowerCaseQuery) ||
          item.name.toLowerCase().contains(lowerCaseQuery);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          width: MediaQuery.of(context).size.width * 0.65,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Image.asset('assets/logo.PNG'),
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        ListTile(
                          title: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Icon(Icons.notification_add_outlined,
                                //     color: Color.fromRGBO(15, 5, 158, 1)),
                                Text('1  Prototype',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(15, 5, 158, 1)))
                              ]),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(const Dashboard()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const Dashboard()));
                          },
                        ),
                        ListTile(
                          title: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Icon(Icons.notification_add_outlined,
                                //     color: Color.fromRGBO(15, 5, 158, 1)),
                                Text('2  Prototype',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(15, 5, 158, 1)))
                              ]),
                          onTap: () {
                            Navigator.of(context)
                                .push(_createRoute(const InwardStatus2()));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const InwardStatus2()));
                          },
                        ),
                        // ListTile(
                        //   title: const Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(Icons.notification_add_outlined,
                        //             color: Color.fromRGBO(15, 5, 158, 1)),
                        //         Text('  Notifications',
                        //             style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromRGBO(15, 5, 158, 1)))
                        //       ]),
                        //   onTap: () {},
                        // ),
                        // ListTile(
                        //   title: const Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(Icons.group_add_outlined,
                        //             color: Color.fromRGBO(15, 5, 158, 1)),
                        //         Text('  New User',
                        //             style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromRGBO(15, 5, 158, 1)))
                        //       ]),
                        //   onTap: () {},
                        // ),
                        // ListTile(
                        //   title: const Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(Icons.restart_alt_rounded,
                        //             color: Color.fromRGBO(15, 5, 158, 1)),
                        //         Text('  New User',
                        //             style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromRGBO(15, 5, 158, 1)))
                        //       ]),
                        //   onTap: () {},
                        // ),
                        // ListTile(
                        //   title: const Row(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       children: [
                        //         Icon(Icons.logout,
                        //             color: Color.fromRGBO(15, 5, 158, 1)),
                        //         Text('  Log Out',
                        //             style: TextStyle(
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Color.fromRGBO(15, 5, 158, 1)))
                        //       ]),
                        //   onTap: () {
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => const LoginScreen()));
                        //   },
                        // ),
                      ],
                    ),
                  ],
                )
              ]),
        ),
      ),
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 30),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
        // leadingWidth: 120,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(Icons.arrow_back),
        //   color: Colors.white,
        // ),
        actions: [
          Container(
            child: TextButton(
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(_createRoute(const LoginScreen()));
              },
            ),
          )
        ],
        title: const Text(
          'Inward Status',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.open_in_browser_sharp),
      //       label: 'Inward',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.repeat_rounded),
      //       label: 'Renewal',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.camera_outlined),
      //       label: 'Endorsements',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.library_books_outlined),
      //       label: 'Digital Forms',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: const Color.fromRGBO(15, 5, 158, 1),
      //   onTap: _onItemTapped,
      // ),
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
                        const Color.fromARGB(255, 243, 242, 242)),
                    // onTap: () {
                    //   _controller.openView();
                    // },
                    onChanged: (query) {
                      // _controller.openView();
                      setState(() {
                        _isSearching = true;
                      });

                      _search(query);
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
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.04,
          // ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusContainer('6', 'Proposal \nSourced', Colors.grey),
                _statusContainer('5', 'Discrepency', Colors.orangeAccent),
                _statusContainer('3', 'Declined', Colors.red),
                _statusContainer('10', 'Completed', Colors.green),
              ],
            ),
          ),
          Expanded(
            child: _isSearching && _searchResult.isEmpty
                ? const Center(
                    child: Text(
                      'No data found!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 85, 85, 85)),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount:
                        _isSearching ? _searchResult.length : employees.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = _isSearching
                          ? _searchResult[index]
                          : employees[index];
                      return Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color.fromRGBO(15, 5, 158, 0.4),
                                  width: 2)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        // 'Inward Number: ${employees[index].inwardNo} ',
                                        'Inward Number: ${item.inwardNo}',
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
                                        'Customer Name: ${item.name}',
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
                                        'Agreement Code: ${item.code} ',
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
                                        'Product: ${item.product} ',
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
                                        'Premium Amount: ${item.amount} ',
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
                                        'Form Type: ${item.type} ',
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
                                        'Date: ${item.date} ',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 5,
                                            bottom: 5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                            color: (item.status == 'Declined')
                                                ? Colors.red
                                                : item.status == 'Completed'
                                                    ? Colors.green
                                                    : item.status ==
                                                            'Disrepency'
                                                        ? Colors.orangeAccent
                                                        : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            ' ${item.status} ',
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

  _statusContainer(String number, String status, Color color) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.24,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: const [
            BoxShadow(
              color:
                  //  Color.fromRGBO(231, 181, 229, 0.9),
                  Colors.black26,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 5  horizontally
                3.0, // Move to bottom 5 Vertically
              ),
            ),
          ],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                status,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
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
