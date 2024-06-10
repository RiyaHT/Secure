import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:secure_app/customProvider.dart';
import 'package:secure_app/layout.dart';
import 'package:secure_app/mpin.dart';

class OtpBox extends StatefulWidget {
  final focusNode;
  final formKey;
  final controller;

  const OtpBox({
    super.key,
    required this.focusNode,
    required this.formKey,
    required this.controller,
  });

  @override
  State<OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<OtpBox> {
  List<Widget> otpInputArray = [];
  List otp = ['', '', '', ''];

  @override
  void initState() {
    super.initState();
    bool first = true;
    bool last = false;
    for (int i = 0; i < 4; i++) {
      if (i != 0) {
        first = false;
      }

      if (i == 3) {
        last = true;
      }

      otpInputArray.add(
          _textFieldOTP(first: first, last: last, index: i, context: context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    // return Stack(
    //   children: [
    // Positioned(
    //     bottom: 0,
    //     right: 0,
    //     left: 0,
    //     top: 0,
    //     child: Container(
    //       decoration:
    //           BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
    //     )),
    // Positioned(
    //   bottom: 90,
    //   left: 25,
    //   right: 25,
    //   child:
    return Container(
        // height: 300,
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
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.2,
                        right: MediaQuery.of(context).size.width * 0.2,
                        top: MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const Text(
                      'VERIFICATION',
                      style: TextStyle(
                          color: Color.fromRGBO(15, 5, 158, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: otpInputArray),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 45, right: 45, top: 15),
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
                            'Verify OTP',
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
                        if (int.parse(otp.join('')) == appState.otp) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LayoutScreen(
                                        cWidget: 2,
                                      )));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  const Text("Invalid OTP. Please try again! "),
                              action: SnackBarAction(
                                label: ' Cancel',
                                onPressed: () {},
                              )));
                        }
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
                      Icons.verified_user_outlined,
                      size: 50,
                      color: Color.fromRGBO(15, 5, 158, 1),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ));
    //     )
    //   ],
    // );
  }

  _textFieldOTP({required bool first, last, context, index}) {
    return SizedBox(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: TextField(
          autofocus: true,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
            otp[index] = value;
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromRGBO(15, 5, 158, 1),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
