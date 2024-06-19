import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:secure_app/InwardDetails.dart';
import 'package:secure_app/inwardForm%201.dart';
import 'package:secure_app/inwardScreen.dart';
import 'package:secure_app/kycIndividual.dart';
// import 'package:secure_app/inwardForm%201.dart';
// import 'package:secure_app/kyc.dart';
import 'package:secure_app/layout.dart';
import 'package:secure_app/login.dart';
import 'package:secure_app/uploadProposal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String employeeNo = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => _prefs.then((SharedPreferences prefs) {
        employeeNo = prefs.getString('employeeNo') ?? '';

        if (employeeNo == '') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LayoutScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }),
    );
    // () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const InwardDetailsScreen())));

    return Scaffold(
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(children: [
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 230,
                        height: 170,
                        child: Image.asset('assets/new_logo.jpg'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: const Color.fromRGBO(13, 154, 189, 1),
                          rightDotColor: Color.fromRGBO(145, 5, 158, 1),
                          size: 35,
                        ),
                      ),
                    ]),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                              '© SBI General Insurance Company Limited | All Rights Reserved.',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 9,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(15, 5, 158, 1),
                              )),
                        ),
                      ]),
                ),
              ),
            ])));
  }
}

// const Color.fromRGBO(13, 154, 189, 1),
// const Color.fromRGBO(11, 133, 163, 1),