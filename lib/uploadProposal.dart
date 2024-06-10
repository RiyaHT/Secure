import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:secure_app/customProvider.dart';
import 'package:secure_app/dashboard.dart';
import 'package:secure_app/dioSingleton.dart';
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

  get prefs => null;

  // uploadProposal() async {
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Accept": "application/json",
  //     "Authorization":
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsImVtYWlsIjoiYXJ5YUBzYmlnZW5lcmFsLmluIiwiaWF0IjoxNzE3NDgyMDQ0fQ.GF5_JFoyyl8q-tM5uHF5aCRl3G21TxIsOQxKSVmbcyY'
  //   };
  //   try {
  //     final response = await dio.post(
  //         'https://ansappsuat.sbigen.in/SecureApp/endorsementDetails',
  //         data: widget.inwardData,
  //         options: Options(headers: headers));

  //     Navigator.pushReplacement(

  //         // ignore: use_build_context_synchronously
  //         context,
  //         MaterialPageRoute(builder: (context) => const Dashboard()));
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

  uploadEndorsement() async {
    // String apiLink = dotenv.env['API_LINK']!;
    // final appState = Provider.of<AppState>(context, listen: false);
    // var token = prefs.getString('token') ?? '';
    Map<String, String> headers = {
      // 'Content-Type': 'application/json; charset=UTF-8',
      // "Accept": "application/json",
      'Content-Type': 'multipart/form-data',
      "Authorization":
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsImVtYWlsIjoiYXJ5YUBzYmlnZW5lcmFsLmluIiwiaWF0IjoxNzE3NDgyMDQ0fQ.GF5_JFoyyl8q-tM5uHF5aCRl3G21TxIsOQxKSVmbcyY'
    };
    final formData = FormData.fromMap({
      'proposal_id': "5926717",
      'doc_type': 'proposal',
      'files': [
        for (var file in documents['proposalDocuments']!)
          {
            await MultipartFile.fromFile(file.path,
                filename: file.path.split('/').last),
          }
      ]
    });

    print(formData.fields);

    try {
      final response = await dio.post(
          'https://uatcld.sbigeneral.in/SecureApp/proposalDocument',
          data: formData,
          options: Options(headers: headers));
      final Map<String, dynamic> data = jsonDecode(response.data);
      print(data);
      print('form submitted');
      // Navigator.pushReplacement(
      //     // ignore: use_build_context_synchronously
      //     context,
      //     MaterialPageRoute(builder: (context) => const Dashboard()));
    } on DioException catch (error) {
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
          'Proposal Documents',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      body: Container(
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
                  return _uploadDocument(
                      'Upload\nProposal\nDocument', index, 'proposalDocuments');
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
                      uploadEndorsement();
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
