import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:secure_app/layout.dart';
import 'package:secure_app/otp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customProvider.dart';

class RegisterBox extends StatefulWidget {
  final focusNode;
  final formKey;
  final controller;

  const RegisterBox({
    super.key,
    required this.focusNode,
    required this.formKey,
    required this.controller,
  });

  @override
  State<RegisterBox> createState() => _RegisterBoxState();
}

class _RegisterBoxState extends State<RegisterBox> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Dio dio = DioSingleton.dio;
  bool isValidating = false;

  generateOTP() async {
    setState(() {
      isValidating = true;
    });
    // String apiLink = dotenv.env['API_LINK']!;
    print("riyaaaaaaaaaaaaaaaaaaaa");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
    };
    final appState = Provider.of<AppState>(context, listen: false);
    try {
      final response = await dio.get(
          'https://uatcld.sbigeneral.in/SecureApp/check-user/${widget.controller.text}',
          options: Options(headers: headers));
      final Map<String, dynamic> data = jsonDecode(response.data);
      if (data['is_active'] == true) {
        _prefs.then((SharedPreferences pref) => {
              pref.setString('token', data['token']),
            });
        Map<String, dynamic> postData = {'user_id': widget.controller.text};
        Map<String, String> headers2 = {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": '${data['token']}'
        };
        final response = await dio.post(
            'https://uatcld.sbigeneral.in/SecureApp/user/set-otp',
            data: postData,
            options: Options(headers: headers2));
        if (response.statusCode == 200) {
          setState(() {
            isValidating = false;
          });
          final Map<String, dynamic> data2 = jsonDecode(response.data);
          print(response.data);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LayoutScreen(
                        cWidget: 1,
                      )));
          appState.updateVariables(
            mobileNumber: data2['mobileNumber'],
            otp: data2['otp'],
            employeeNo: widget.controller.text,
          );
        }
      }
    } catch (error) {
      setState(() {
        isValidating = false;
      });
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Inactive User"),
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
                            right: MediaQuery.of(context).size.width * 0.2,
                            top: MediaQuery.of(context).size.height * 0.1,
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Color.fromRGBO(15, 5, 158, 1),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                      ),
                      Form(
                        key: widget.formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 20),
                          child: TextFormField(
                            controller: widget.controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 6,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black12, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromRGBO(15, 5, 158, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
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
                              labelText: 'Enter Employee Id',
                              labelStyle: TextStyle(
                                  color: widget.focusNode.hasFocus
                                      ? const Color.fromRGBO(15, 5, 158, 1)
                                      : Colors.grey),
                            ),
                            focusNode: widget.focusNode,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter the Employee ID';
                              } else if (int.parse(value) == 0) {
                                return 'Invalid Employee ID';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 45, right: 45, top: 15),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(15, 5, 158, 1),
                              elevation: 10, // Elevation
                              shadowColor:
                                  const Color.fromRGBO(15, 5, 158, 0.3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Generate OTP',
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
                            print('clicked');
                            // if (widget.formKey.currentState!.validate()
                            // widget.controller.text == '12345'
                            // ) {
                            generateOTP();
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const LayoutScreen(
                            //               cWidget: 1,
                            //             )));
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //       content: const Text("Inactive user. "),
                            //       action: SnackBarAction(
                            //         label: ' Cancel',
                            //         onPressed: () {},
                            //       )));
                            // }
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
                          Icons.person_2_outlined,
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
