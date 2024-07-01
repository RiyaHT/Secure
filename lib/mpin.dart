import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:secure_app/customProvider.dart';
import 'package:secure_app/dashboard.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpinBox extends StatefulWidget {
  const MpinBox({
    super.key,
  });

  @override
  State<MpinBox> createState() => _MpinBoxState();
}

class _MpinBoxState extends State<MpinBox> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  Dio dio = DioSingleton.dio;
  String token = '';
  bool isValidating = false;

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  final Map<dynamic, dynamic> _focusUnfocus = {
    "focus_node_1": false,
    "focus_node_2": false,
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
  }

  setMPIN() async {
    setState(() {
      isValidating = true;
    });
    // String apiLink = dotenv.env['API_LINK']!;
    final appState = Provider.of<AppState>(context, listen: false);
    SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token') ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": token
    };
    Map<String, dynamic> postData = {
      'user_id': appState.employeeNo,
      'mpin': _controller.text
    };

    try {
      final response = await dio.post(
          'https://uatcld.sbigeneral.in/SecureApp/user/set-mpin',
          data: postData,
          options: Options(headers: headers));
      // final Map<String, dynamic> data = jsonDecode(response.data);
      print(response.data);
      setState(() {
        isValidating = false;
      });
      _prefs.then((SharedPreferences pref) => {
            pref.setString('phoneNumber', appState.mobileNumber),
            pref.setString('employeeNo', appState.employeeNo),
            pref.setString('name', appState.name),
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()))
          });
    } catch (error) {
      setState(() {
        isValidating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Try Again!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                        top: MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const Text(
                      'SET-UP MPIN',
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
                          left: 15.0, right: 15.0, bottom: 10),
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 4,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black12, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 5, 158, 1), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          prefixIconColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused)) {
                              return const Color.fromRGBO(15, 5, 158, 1);
                            }
                            return Colors.grey;
                          }),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'New MPIN',
                          labelStyle: TextStyle(
                              color: focusNode1.hasFocus
                                  ? const Color.fromRGBO(15, 5, 158, 1)
                                  : Colors.grey),
                          hintText: 'Enter valid 4-Digit MPIN',
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 10),
                      child: TextFormField(
                        controller: _controller2,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 4,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black12, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 5, 158, 1), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(
                            Icons.password,
                          ),
                          prefixIconColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused)) {
                              return const Color.fromRGBO(15, 5, 158, 1);
                            }
                            return Colors.grey;
                          }),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Confirm MPIN',
                          labelStyle: TextStyle(
                              color: focusNode2.hasFocus
                                  ? const Color.fromRGBO(15, 5, 158, 1)
                                  : Colors.grey),
                          hintText: 'Confirm MPIN',
                        ),
                        focusNode: focusNode2,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter the MPIN';
                          } else if (int.parse(value) == 0) {
                            return 'Invalid MPIN';
                          } else if (value.length < 4) {
                            return 'Please enter 4-Digit MPIN';
                          } else if (_controller.text != _controller2.text) {
                            return "MPIN Doesn't match";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 45,
                      right: 45,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(15, 5, 158, 1),
                          elevation: 10, // Elevation
                          shadowColor: const Color.fromRGBO(15, 5, 158, 0.3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 25,
                            color: Colors.white,
                          )
                        ],
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                                _formKey2.currentState!.validate()

                            // _controller.text == '1111'

                            ) {
                          setMPIN();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const Dashboard()),
                          // );
                        }
                        // widget.buttonClicked();
                      },
                    ),
                  ),
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
                          Icons.password_outlined,
                          size: 50,
                          color: Color.fromRGBO(15, 5, 158, 1),
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
      ],
    );
  }
}
