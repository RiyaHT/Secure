import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:secure_app/BarChartWidge.dart';
// import 'package:secure_app/GrowthChartWidget.dart';
import 'package:secure_app/inwardScreen.dart';
// import 'package:secure_app/inwardForm.dart';
// import 'package:secure_app/inwardStatus.dart';
import 'package:secure_app/login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  List<Data> data = <Data>[];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    data = getData();
  }

//   void openDrawer() {
//     print('clicked');
// //    Scaffold.of(context).openDrawer();
//     Drawer();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_outlined),
            label: 'Notificaations',
          ),
          BottomNavigationBarItem(
            icon: Icon((Icons.group_add_outlined)),
            label: 'New User',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.restart_alt_rounded),
          //   label: 'Reset Password',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(15, 5, 158, 1),
        onTap: _onItemTapped,
      ),
      // drawer: SafeArea(
      //   child: Drawer(
      //     width: MediaQuery.of(context).size.width * 0.65,
      //     // Add a ListView to the drawer. This ensures the user can scroll
      //     // through the options in the drawer if there isn't enough vertical
      //     // space to fit everything.
      //     child: ListView(
      //         // Important: Remove any padding from the ListView.
      //         padding: EdgeInsets.zero,
      //         children: [
      //           DrawerHeader(
      //             decoration: const BoxDecoration(
      //               color: Colors.white,
      //             ),
      //             child: SizedBox(
      //               width: MediaQuery.of(context).size.width / 3,
      //               height: MediaQuery.of(context).size.height / 5,
      //               child: const Wrap(
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     children: [
      //                       SizedBox(
      //                         height: 25,
      //                       ),
      //                       Text('Welcome,\nPravat',
      //                           style: TextStyle(
      //                               color: Color.fromRGBO(105, 10, 124, 0.894),
      //                               fontSize: 22,
      //                               fontWeight: FontWeight.bold)),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               // child: Image.asset('assets/logo.PNG'),
      //             ),
      //           ),
      //           Stack(
      //             children: [
      //               Column(
      //                 children: [
      //                   ListTile(
      //                     title: const Row(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //                           // Icon(Icons.notification_add_outlined,
      //                           //     color: Color.fromRGBO(15, 5, 158, 1)),
      //                           Text('1  Prototype',
      //                               style: TextStyle(
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.w600,
      //                                   color: Color.fromRGBO(15, 5, 158, 1)))
      //                         ]),
      //                     onTap: () {
      //                       Navigator.of(context)
      //                           .push(_createRoute(const Dashboard()));
      //                       // Navigator.pushReplacement(
      //                       //     context,
      //                       //     MaterialPageRoute(
      //                       //         builder: (context) => const Dashboard()));
      //                     },
      //                   ),
      //                   ListTile(
      //                     title: const Row(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: [
      //                           // Icon(Icons.notification_add_outlined,
      //                           //     color: Color.fromRGBO(15, 5, 158, 1)),
      //                           Text('2  Prototype',
      //                               style: TextStyle(
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.w600,
      //                                   color: Color.fromRGBO(15, 5, 158, 1)))
      //                         ]),
      //                     onTap: () {
      //                       Navigator.of(context)
      //                           .push(_createRoute(const InwardStatus2()));
      //                       // Navigator.pushReplacement(
      //                       //     context,
      //                       //     MaterialPageRoute(
      //                       //         builder: (context) =>
      //                       //             const InwardStatus2()));
      //                     },
      //                   ),
      //                   // ListTile(
      //                   //   title: const Row(
      //                   //       mainAxisAlignment: MainAxisAlignment.start,
      //                   //       children: [
      //                   //         Icon(Icons.notification_add_outlined,
      //                   //             color: Color.fromRGBO(15, 5, 158, 1)),
      //                   //         Text('  Notifications',
      //                   //             style: TextStyle(
      //                   //                 fontSize: 15,
      //                   //                 fontWeight: FontWeight.w600,
      //                   //                 color: Color.fromRGBO(15, 5, 158, 1)))
      //                   //       ]),
      //                   //   onTap: () {},
      //                   // ),
      //                   // ListTile(
      //                   //   title: const Row(
      //                   //       mainAxisAlignment: MainAxisAlignment.start,
      //                   //       children: [
      //                   //         Icon(Icons.group_add_outlined,
      //                   //             color: Color.fromRGBO(15, 5, 158, 1)),
      //                   //         Text('  New User',
      //                   //             style: TextStyle(
      //                   //                 fontSize: 15,
      //                   //                 fontWeight: FontWeight.w600,
      //                   //                 color: Color.fromRGBO(15, 5, 158, 1)))
      //                   //       ]),
      //                   //   onTap: () {},
      //                   // ),
      //                   // ListTile(
      //                   //   title: const Row(
      //                   //       mainAxisAlignment: MainAxisAlignment.start,
      //                   //       children: [
      //                   //         Icon(Icons.restart_alt_rounded,
      //                   //             color: Color.fromRGBO(15, 5, 158, 1)),
      //                   //         Text('  New User',
      //                   //             style: TextStyle(
      //                   //                 fontSize: 15,
      //                   //                 fontWeight: FontWeight.w600,
      //                   //                 color: Color.fromRGBO(15, 5, 158, 1)))
      //                   //       ]),
      //                   //   onTap: () {},
      //                   // ),
      //                   // ListTile(
      //                   //   title: const Row(
      //                   //       mainAxisAlignment: MainAxisAlignment.start,
      //                   //       children: [
      //                   //         Icon(Icons.logout,
      //                   //             color: Color.fromRGBO(15, 5, 158, 1)),
      //                   //         Text('  Log Out',
      //                   //             style: TextStyle(
      //                   //                 fontSize: 15,
      //                   //                 fontWeight: FontWeight.w600,
      //                   //                 color: Color.fromRGBO(15, 5, 158, 1)))
      //                   //       ]),
      //                   //   onTap: () {
      //                   //     Navigator.pushReplacement(
      //                   //         context,
      //                   //         MaterialPageRoute(
      //                   //             builder: (context) => const LoginScreen()));
      //                   //   },
      //                   // ),
      //                 ],
      //               ),
      //             ],
      //           )
      //         ]),
      //   ),
      // ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu,
                  color: Color.fromRGBO(15, 5, 158, 1), size: 30),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
          ],
        ),
        leadingWidth: 140,
        // title: Container(
        //   height: 60,
        //   padding: const EdgeInsets.fromLTRB(0, 7, 15, 7),
        //   child: Image.asset(
        //     "assets/secure.PNG",
        //     fit: BoxFit.cover,
        //   ),
        // ),
        // centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            // width: 80,
            height: 50,
            padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
            child: Image.asset(
              "assets/new_secure.PNG",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(13, 154, 189, 0.15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
                Container(
                    margin: const EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.height * 0.22,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                //  Color.fromRGBO(231, 181, 229, 0.9),
                                Color.fromRGBO(15, 5, 158, 0.4),
                            blurRadius: 5.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              3.0, // Move to right 5  horizontally
                              3.0, // Move to bottom 5 Vertically
                            ),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: const Color.fromRGBO(13, 154, 189, 1),
                                  width: 3)
                              //     border: Border(
                              //         bottom: BorderSide(
                              //   color: Color.fromRGBO(15, 5, 158, 0.4),
                              //   width: 2,
                              // ))
                              ),
                          // ),
                          child: InkWell(
                            onTap: () {
                              print(currentIndex);
                            },
                            child: CarouselSlider(
                                items: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const BarChartWidget(),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.18,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const BarChartWidget(),
                                  ),
                                  // Container(
                                  //   height: 15,
                                  //   alignment: Alignment.center,
                                  //   decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(15),
                                  //       image: const DecorationImage(
                                  //           image:
                                  //               AssetImage("assets/sbi_logo.PNG"),
                                  //           fit: BoxFit.fill)),
                                  // )
                                ],
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  aspectRatio: 2.5,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                )),
                          ),

                          // child: const Text(
                          //   'CIRCLE: MUMBAI METRO',
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   textAlign: TextAlign.start,
                          // ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: getData().map((e) {
                        //       return _customRound(
                        //           context, e.icon, e.data, e.number);
                        //     }).toList()),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    // height: MediaQuery.of(context).size.height * 0.55,
                    child: Column(
                  children: [
                    Wrap(spacing: 10, runSpacing: 15, children: [
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      // Container(
                      //   margin: const EdgeInsets.only(
                      //       left: 10, right: 10),
                      //   padding: const EdgeInsets.all(7),
                      //   // width: MediaQuery.of(context).size.width * 0.18,
                      //   // height: MediaQuery.of(context).size.height * 0.12,
                      //   decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     shape: BoxShape.circle,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color:
                      //             //  Color.fromRGBO(231, 181, 229, 0.9),
                      //             Color.fromRGBO(15, 5, 158, 0.4),
                      //         blurRadius: 5.0, // soften the shadow
                      //         spreadRadius: 2.0, //extend the shadow
                      //         offset: Offset(
                      //           3.0, // Move to right 5  horizontally
                      //           3.0, // Move to bottom 5 Vertically
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   child: TextButton(

                      //       // style: _button(),
                      //       onPressed: () {},
                      //       child: Container(
                      //           height: 40,
                      //           width: 40,
                      //           child: Image.asset(
                      //             'assets/form.png',
                      //           ))),
                      // ),
                      //   const SizedBox(
                      //     height: 4,
                      //   ),
                      //   Text(
                      //     'trial',
                      //     textAlign: TextAlign.center,
                      //     style: _textStyle(),
                      //   )
                      // ]),
                      _customButton(
                          Icons.open_in_browser_sharp, 'Inward', context,
                          screenName: const InwardStatus2()),
                      _customButton(Icons.trending_up, 'Performance', context),
                      _customButton(Icons.repeat_rounded, 'Renewal', context),
                      _customButton(Icons.branding_watermark_rounded,
                          'Products', context),
                      _customButton(
                          Icons.keyboard_alt_outlined, 'Premium', context),
                      _customButton(
                          Icons.location_on, 'Hospital \n Location', context),
                      _customButton(
                          Icons.restart_alt_rounded, 'Claim', context),
                      _customButton(
                          Icons.camera_outlined, 'Endorsement', context),
                      _customButton(
                          Icons.leaderboard_outlined, 'Lead', context),
                      _customButton(Icons.checklist_rtl_outlined,
                          'Useful \n Links', context),
                      // _customButton(
                      //     Icons.open_in_browser_sharp, 'Inward', context,
                      //     screenName: const InwardStatus()),
                      _customButton(Icons.library_books_outlined,
                          'Digital \n Forms', context),
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     // width: MediaQuery.of(context).size.width,
        //     // height: MediaQuery.of(context).size.height,
        //     decoration: const BoxDecoration(color: Colors.transparent),
        //     child: Column(
        //         mainAxisAlignment: MainAxisAlignment.end,
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //           Container(
        //             width: double.infinity,
        //             decoration: const BoxDecoration(
        //               color: Color.fromRGBO(5, 131, 163, 0.8),
        //             ),
        //             padding: const EdgeInsets.all(5),
        //             child: const Text('Updated as on : 23-Apr-24',
        //                 textAlign: TextAlign.center,
        //                 maxLines: 2,
        //                 style: TextStyle(
        //                   fontSize: 9,
        //                   letterSpacing: 1.2,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.white,
        //                 )),
        //           ),
        //         ]),
        //   ),
        // ),
      ]),
    );
  }

  List<Data> getData() {
    return [
      Data('GWP', '130', Icons.folder),
      Data('Growth', '30', Icons.auto_graph_outlined),
      Data('Brand \n Activation', '30', Icons.account_balance_outlined),
    ];
  }
}

class Data {
  Data(this.data, this.number, this.icon);

  final String data;
  final String number;
  final IconData icon;
}

Widget _customButton(IconData iconName, String label, context, {screenName}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          padding: const EdgeInsets.all(6),
          // width: MediaQuery.of(context).size.width * 0.18,
          // height: MediaQuery.of(context).size.height * 0.12,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color:
                    //  Color.fromRGBO(231, 181, 229, 0.9),
                    Color.fromRGBO(15, 5, 158, 0.4),
                blurRadius: 5.0, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  3.0, // Move to right 5  horizontally
                  3.0, // Move to bottom 5 Vertically
                ),
              ),
            ],
          ),
          child: TextButton(
              // style: _button(),
              onPressed: () {
                if (screenName != null) {
                  Navigator.of(context).push(_createRoute(screenName));
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => _createRoute( screenName),),
                // );
              },
              child: ShaderMask(
                shaderCallback: _linearGradient,
                child: Icon(
                  iconName,
                  size: 32,
                ),
              )),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: _textStyle(),
        )
      ]);
}

Shader _linearGradient(Rect bounds) {
  return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(176, 34, 204, 0.898),
        Color.fromRGBO(176, 34, 204, 0.898),
        Color.fromRGBO(176, 34, 204, 0.898),
        // Color.fromRGBO(133, 9, 158, 0.9),
        Color.fromRGBO(13, 154, 189, 0.8),
        Color.fromRGBO(13, 154, 189, 0.8),
        Color.fromRGBO(13, 154, 189, 0.8),
        // Color.fromRGBO(21, 194, 206, 0.894),
        // Color.fromRGBO(21, 194, 206, 0.894),
        // Color.fromRGBO(21, 169, 206, 0.898),
        // Color.fromRGBO(21, 169, 206, 0.898),
        // Color.fromRGBO(138, 218, 238, 1),
        // Color.fromRGBO(11, 4, 107, 1),
      ]).createShader(bounds);
}

ButtonStyle _button() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  );
}

BoxDecoration _decoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: const [
      BoxShadow(
        color:
            //  Color.fromRGBO(231, 181, 229, 0.9),
            Color.fromRGBO(15, 5, 158, 0.4),
        blurRadius: 5.0, // soften the shadow
        spreadRadius: 2.0, //extend the shadow
        offset: Offset(
          3.0, // Move to right 5  horizontally
          3.0, // Move to bottom 5 Vertically
        ),
      ),
    ],
  );
}

TextStyle _textStyle() {
  return const TextStyle(
    color: Color.fromRGBO(12, 23, 70, 1),
    letterSpacing: 1.2,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}

Widget _box() {
  return const SizedBox(
    height: 2,
  );
}

Widget _customRound(context, IconData icon, String text, String no) {
  return Container(
    child: Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: TextButton(
            child: ShaderMask(
              shaderCallback: _linearGradient,
              child: Icon(
                icon,
                size: 35,
              ),
            ),
            onPressed: () {},
          ),
        ),
        _box(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: _textStyle(),
        ),
        _box(),
        Text(
          no,
          style: _textStyle(),
        )
      ],
    ),
  );
}

Route _createRoute(screenName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screenName,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);

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
