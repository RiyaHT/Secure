import 'dart:convert';
import 'dart:io';
import 'package:animated_check/animated_check.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:secure_app/customProvider.dart';
import 'package:secure_app/dashboard.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProposalDocuments extends StatefulWidget {
  final inwardData;
  final inwardType;

  ProposalDocuments(
      {super.key, required this.inwardData, required this.inwardType});

  @override
  State<ProposalDocuments> createState() => _ProposalDocumentsState();
}

class _ProposalDocumentsState extends State<ProposalDocuments> {
  File? galleryFile;
  Map<String, List> documents = {'proposalDocuments': [], 'otherDocuments': []};
  Dio dio = DioSingleton.dio;
  final picker = ImagePicker();
  bool isSubmitted = false;
  bool isLoading = false;
  String token = '';

  // late AnimationController _animationController;
  // late Animation<double> _animation;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void initState() {
    super.initState();
    // _animationController =
    //     AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // _animationController.forward();
    // _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    //     parent: _animationController, curve: Curves.easeInOutCirc));
  }

  uploadProposal() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token') ?? '';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": token
    };
    Map<String, String> headers2 = {"Authorization": token};

    try {
      final response = await dio.post(
          'https://uatcld.sbigeneral.in/SecureApp/proposalDetails',
          data: widget.inwardData,
          options: Options(headers: headers));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        print(data);
        var formData = FormData();
        formData.fields
            .add(MapEntry('proposal_id', data['proposal']['id'].toString()));
        formData.fields.add(const MapEntry('doc_type', 'proposal'));
        for (var file in documents['proposalDocuments']!) {
          formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)));
        }
        try {
          final response = await dio.post(
              'https://uatcld.sbigeneral.in/SecureApp/proposalDocument',
              data: formData,
              options: Options(headers: headers2));

          print('form submitted');
          setState(() {
            isSubmitted = true;
            isLoading = false;
          });
        } on DioException catch (error) {
          setState(() {
            isLoading = false;
          });
          print(error.message);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Form not submitted. Try again!"),
              action: SnackBarAction(
                label: ' Cancel',
                onPressed: () {},
              )));
        }
      }
    } on DioException catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error.message);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Form not submitted. Try again!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }

  uploadEndorsement() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token') ?? '';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": token
    };
    Map<String, String> headers2 = {"Authorization": token};

    try {
      final response = await dio.post(
          'https://uatcld.sbigeneral.in/SecureApp/endorsementDetails',
          data: widget.inwardData,
          options: Options(headers: headers));

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        var formData = FormData();
        formData.fields
            .add(MapEntry('proposal_id', data['proposal']['id'].toString()));
        formData.fields.add(const MapEntry('doc_type', 'proposal'));
        for (var file in documents['proposalDocuments']!) {
          formData.files.add(MapEntry(
              'files',
              await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)));
        }
        try {
          final response = await dio.post(
              'https://uatcld.sbigeneral.in/SecureApp/proposalDocument',
              data: formData,
              options: Options(headers: headers2));

          print('form submitted');
          setState(() {
            isSubmitted = true;
            isLoading = false;
          });
        } on DioException catch (error) {
          setState(() {
            isLoading = false;
          });
          print(error.message);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Form not submitted. Try again!"),
              action: SnackBarAction(
                label: ' Cancel',
                onPressed: () {},
              )));
        }
      }
    } on DioException catch (error) {
      setState(() {
        isLoading = false;
      });
      print(error.message);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Form not submitted. Try again!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }
  // uploadEndorsement() async {
  //   // String apiLink = dotenv.env['API_LINK']!;
  //   // final appState = Provider.of<AppState>(context, listen: false);
  //   // var token = prefs.getString('token') ?? '';
  //   Map<String, String> headers = {
  //     // // 'Content-Type': 'application/json; charset=UTF-8',
  //     // // "Accept": "application/json",
  //     // 'Content-Type': 'multipart/form-data',
  //     "Authorization":
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsImVtYWlsIjoiYXJ5YUBzYmlnZW5lcmFsLmluIiwiaWF0IjoxNzE3NDgyMDQ0fQ.GF5_JFoyyl8q-tM5uHF5aCRl3G21TxIsOQxKSVmbcyY'
  //   };

  //   // final formData = FormData.fromMap({
  //   //   'proposal_id': "5926717",
  //   //   'doc_type': 'proposal',
  //   //   // 'files': [
  //   //   //   for (var file in documents['proposalDocuments']!)
  //   //   //     {
  //   //   //   await MultipartFile.fromFile(documents['proposalDocuments']![0].path,
  //   //   //       filename: documents['proposalDocuments']![0].path.split('/').last),
  //   //   //   }
  //   //   // ]
  //   //   'files': documents['proposalDocuments']!.map((e) async {
  //   //     return await MultipartFile.fromFile(
  //   //         documents['proposalDocuments']![0].path,
  //   //         filename: documents['proposalDocuments']![0].path.split('/').last);
  //   //   }).toList()
  //   // });

  //   var formData = FormData();
  //   formData.fields.add(const MapEntry('proposal_id', '5926717'));
  //   formData.fields.add(const MapEntry('doc_type', 'proposal'));
  //   for (var file in documents['proposalDocuments']!) {
  //     formData.files.add(MapEntry(
  //         'files',
  //         await MultipartFile.fromFile(file.path,
  //             filename: file.path.split('/').last)));
  //   }

  //   try {
  //     final response = await dio.post(
  //         'https://uatcld.sbigeneral.in/SecureApp/proposalDocument',
  //         data: formData,
  //         options: Options(headers: headers));
  //     // final Map<String, dynamic> data = jsonDecode(response.data);
  //     // print(data);
  //     print('form submitted');
  //     setState(() {
  //       isSubmitted = true;
  //     });
  //     // Navigator.pushReplacement(
  //     //     // ignore: use_build_context_synchronously
  //     //     context,
  //     //     MaterialPageRoute(builder: (context) => const Dashboard()));
  //   } on DioException catch (error) {
  //     print(error.message);
  //     // ignore: use_build_context_synchronously
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: const Text("Form not submitted. Try again!"),
  //         action: SnackBarAction(
  //           label: ' Cancel',
  //           onPressed: () {},
  //         )));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              title: const Text(
                'Proposal Documents',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
              titleTextStyle: const TextStyle(color: Colors.white),
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Proposal Documents*: ',
                          maxLines: 2,
                          style: TextStyle(
                              color: Color.fromRGBO(11, 133, 163, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        _heightGap(),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          runSpacing: 15,
                          children: List.generate(4, (index) {
                            return _uploadDocument('Upload\nProposal\nDocument',
                                index, 'proposalDocuments');
                          }),
                        ),
                        _heightGap(),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromRGBO(11, 133, 163, 1),
                          ),
                          child: TextButton(
                              onPressed: () {
                                print('submit');
                                // print(widget.inwardData);
                                // uploadEndorsement();
                                if (widget.inwardType == 'Endorsement') {
                                  uploadEndorsement();
                                } else {
                                  uploadProposal();
                                }
                              },
                              child: const Text(
                                'Submit Inward',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                        // const Text(
                        //   'Upload Other Documents: ',
                        //   maxLines: 2,
                        //   style: TextStyle(
                        //       color: Color.fromRGBO(11, 133, 163, 1),
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // _heightGap(),
                        // Wrap(
                        //   spacing: 10,
                        //   children: List.generate(4, (index) {
                        //     return _uploadDocument(
                        //         'Upload\nOther\nDocument', index, 'otherDocuments');
                        //   }),
                        // ),
                        // _heightGap(),
                      ],
                    ),
                  ),
                ),
                isSubmitted
                    ? Positioned(
                        // left: 20,
                        // right: 20,
                        // top: 40,
                        // bottom: 40,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration:
                                  const BoxDecoration(color: Colors.black38),
                            ),
                            Center(
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(40, 160, 40, 160),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
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
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            13, 154, 189, 0.4),
                                        width: 4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Form Submitted Succcessfully!',
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(38, 173, 20, 1),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                //  Color.fromRGBO(231, 181, 229, 0.9),
                                                Color.fromRGBO(15, 5, 158, 0.4),
                                            blurRadius:
                                                5.0, // soften the shadow
                                            spreadRadius:
                                                2.0, //extend the shadow
                                            offset: Offset(
                                              3.0, // Move to right 5  horizontally
                                              3.0, // Move to bottom 5 Vertically
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Dashboard())),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            )),
        isLoading
            ? Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.7)),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        const Text('Loading Data...',
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

  _heightGap() {
    return const SizedBox(height: 10);
  }

  _uploadDocument(String label, int index, String type) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 120.0,
          width: 140.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: const Color.fromRGBO(13, 154, 189, 1), width: 2)),
          child: documents[type]!.length > index
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: documents[type]![index].path.endsWith('.pdf')
                        ? PDFView(
                            filePath: documents[type]![index].path,
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: false,
                            pageSnap: true,
                          )
                        : Image.file(documents[type]![index]),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        backgroundColor: Color.fromRGBO(235, 234, 234, 0.663)),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color.fromRGBO(11, 133, 163, 1),
                      ),
                    ),
                    onPressed: () {
                      _showPicker(context: context, type: type, index: index);
                    },
                  ),
                ),
        ),
        documents[type]!.length > index
            ? Positioned(
                top: -20,
                right: -30,
                child: TextButton(
                  child: const Text(
                    'X',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      documents[type]!.removeAt(index);
                    });
                  },
                ),
              )
            : const Text('')
      ],
    );
  }

  Future<void> _pickPDF(String type, int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        if (documents[type]!.length > index) {
          documents[type]![index] = File(result.files.single.path!);
        } else {
          documents[type]!.add(File(result.files.single.path!));
        }
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No document selected')),
      );
    }
  }

  void _showPicker(
      {required BuildContext context,
      required String type,
      required int index}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery, type, index);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera, type, index);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('PDF'),
                onTap: () {
                  _pickPDF(type, index);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img, String type, int index) async {
    final pickedFile = await picker.pickImage(source: img);
    if (pickedFile != null) {
      setState(() {
        if (documents[type]!.length > index) {
          documents[type]![index] = File(pickedFile.path);
        } else {
          documents[type]!.add(File(pickedFile.path));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No document selected')),
      );
    }
  }
}
