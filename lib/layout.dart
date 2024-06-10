import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:secure_app/mpin.dart';
import 'package:secure_app/register.dart';
import 'package:secure_app/otp.dart';

class LayoutScreen extends StatefulWidget {
  final int cWidget;
  const LayoutScreen({super.key, this.cWidget = 0});

  @override
  State<LayoutScreen> createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode1 = FocusNode();
  final _controller = TextEditingController();
  var widgetArr = [];
  int currentWidget = 0;
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    addListenerToNode(focusNode1, "focus_node_1");
    widgetArr = [
      RegisterBox(
        focusNode: focusNode1,
        formKey: _formKey,
        controller: _controller,
      ),
      OtpBox(
        focusNode: focusNode1,
        formKey: _formKey,
        controller: _controller,
      ),
      const MpinBox(),
    ];
    setState(() {
      currentWidget = widget.cWidget;
    });
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
  }

  buttonClickListener() {
    if (currentWidget == widgetArr.length) {
      setState(() {
        currentWidget = 0;
      });
    }
    setState(() {
      currentWidget++;
    });
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
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
              widgetArr[currentWidget]
            ],
          ),
        ),

        // _focusUnfocus["focus_node_1"]
        //     ? Positioned(
        //         bottom: 0,
        //         right: 0,
        //         left: 0,
        //         top: 0,
        //         child: Container(
        //           decoration: BoxDecoration(
        //               color: Colors.grey.shade200.withOpacity(0.8)),
        //         ))
        //     : Container(),
      ]),
    );
  }
}
