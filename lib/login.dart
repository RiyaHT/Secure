import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:secure_app/customProvider.dart';
import 'package:secure_app/dashboard.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:secure_app/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String employeeNo = '';
  String token = '';
  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final _controller = TextEditingController();
  bool isValidating = false;
  Dio dio = DioSingleton.dio;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final Map<dynamic, dynamic> _focusUnfocus = {
    "focus_node_1": false,
  };

  addListenerToNode(FocusNode focusNode, String key) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _focusUnfocus[key] = true;
      } else {
        _focusUnfocus[key] = false;
      }
      setState(() {});
    });
    _prefs.then((SharedPreferences prefs) async {});
  }

  verifyMPIN() async {
    setState(() {
      isValidating = true;
    });
    // String apiLink = dotenv.env['API_LINK']!;

    SharedPreferences prefs = await _prefs;
    // final appState = Provider.of<AppState>(context, listen: false);

    var employeeNo = prefs.getString('employeeNo') ?? '';
    var token = prefs.getString('token') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": token
    };
    try {
      final response = await dio.get(
          'https://uatcld.sbigeneral.in/SecureApp/check-user/$employeeNo',
          options: Options(headers: headers));
      final Map<String, dynamic> data = jsonDecode(response.data);
      if (data['is_active'] == true) {
        Map<String, dynamic> postData = {
          'user_id': employeeNo,
          'mpin': _controller.text
        };
        final response = await dio.post(
            'https://uatcld.sbigeneral.in/SecureApp/user/check-mpin',
            data: postData,
            options: Options(headers: headers));
        if (response.statusCode == 200) {
          setState(() {
            isValidating = false;
          });
          print(response.data);
          // final Map<String, dynamic> data = jsonDecode(response.data);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        }
      }
    } catch (error) {
      setState(() {
        isValidating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Invalid MPIN. Please try again!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 10);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
          // width: 80,
          height: 50,
          // padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
          child: Image.asset(
            "assets/sbi_logo.PNG",
            fit: BoxFit.cover,
          ),
        ),
        leadingWidth: 180,
        actions: [
          Container(
            // width: 80,
            height: 60,
            padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
            child: Image.asset(
              "assets/new_secure.PNG",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.white),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  height: MediaQuery.of(context).size.height / 8,
                  color: const Color.fromRGBO(15, 5, 158, 0.6),
                ),
              ),
              ClipPath(
                clipper: WaveClipperOne(flip: true, reverse: true),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  color: const Color.fromRGBO(26, 187, 228, 0.4),
                ),
              ),
              ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height / 12,
                  color: const Color.fromRGBO(23, 10, 206, 0.38),
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //     bottom: 0,
        //     left: 0,
        //     right: 0,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height / 3,
        //       decoration: const BoxDecoration(
        //         gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.white,
        //             Color.fromRGBO(26, 187, 228, 0.7),
        //             Color.fromRGBO(15, 5, 158, 0.7),
        //           ],
        //         ),
        //       ),
        //     )),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              const SizedBox(
                // width: MediaQuery.of(context).size.width / 3,
                // height: MediaQuery.of(context).size.height / 5,
                child: Text('Welcome to Secure Portal',
                    style: TextStyle(
                        color: Color.fromRGBO(105, 10, 124, 0.894),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                  // height: MediaQuery.of(context).size.height * 0.53,
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(12),
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
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.2,
                                  right:
                                      MediaQuery.of(context).size.width * 0.2,
                                  top: MediaQuery.of(context).size.height * 0.1,
                                  bottom: MediaQuery.of(context).size.height *
                                      0.03),
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: Color.fromRGBO(15, 5, 158, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15.0, bottom: 20),
                                child: TextFormField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 6,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black12, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromRGBO(15, 5, 158, 1),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person,
                                    ),
                                    prefixIconColor:
                                        MaterialStateColor.resolveWith(
                                            (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.focused)) {
                                        return const Color.fromRGBO(
                                            15, 5, 158, 1);
                                      }
                                      return Colors.grey;
                                    }),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    labelText: 'Enter your MPIN',
                                    labelStyle: TextStyle(
                                        color: focusNode1.hasFocus
                                            ? const Color.fromRGBO(
                                                15, 5, 158, 1)
                                            : Colors.grey),
                                  ),
                                  focusNode: focusNode1,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter the MPIN';
                                    } else if (int.parse(value) == 0) {
                                      return 'Invalid MPIN';
                                    } else if (value.length < 4) {
                                      return 'Please enter 4-Digit MPIN';
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 45, right: 45, top: 15),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(15, 5, 158, 1),
                                    elevation: 10, // Elevation
                                    shadowColor:
                                        const Color.fromRGBO(15, 5, 158, 0.3),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sign In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 25,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()
                                      // _controller.text == 1111

                                      ) {
                                    verifyMPIN();
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Dashboard()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: const Text(
                                                "Invalid MPIN. Please try again! "),
                                            action: SnackBarAction(
                                              label: ' Cancel',
                                              onPressed: () {},
                                            )));
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            TextButton(
                                onPressed: () {
                                  _prefs.then((SharedPreferences prefs) {
                                    prefs.setString('employeeNo', '');
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LayoutScreen()));
                                  });
                                },
                                child: const Text('Forgot MPIN?',
                                    style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 1,
                                        color: Color.fromARGB(255, 33, 47, 243),
                                        fontWeight: FontWeight.bold))),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.02,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Haven't registered?",
                            //         style: TextStyle(
                            //           fontSize: 12,
                            //           color: Colors.black,
                            //         )),
                            //     TextButton(
                            //         onPressed: () {
                            //           Navigator.pushReplacement(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       const Dashboard()));
                            //         },
                            //         child: const Text('Sign Up',
                            //             style: TextStyle(
                            //                 fontSize: 12, color: Colors.blue)))
                            //   ],
                            // ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            )
                          ]),
                      Positioned(
                        top: -45,
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              // borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.circle,
                              boxShadow: [
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
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Center(
                              child: Container(
                                  child: const Icon(
                                Icons.lock_open,
                                size: 50,
                                color: Color.fromRGBO(15, 5, 158, 1),
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        isValidating
            ? Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        const Text('Please Wait...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(15, 5, 158, 1),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        LoadingAnimationWidget.threeArchedCircle(
                          color: const Color.fromRGBO(15, 5, 158, 1),
                          size: 50,
                        ),
                      ])),
                ),
              )
            : Container()
      ]),
    );
  }
}
