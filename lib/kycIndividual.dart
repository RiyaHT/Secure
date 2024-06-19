import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:secure_app/DatePickerFormField.dart';
import 'package:secure_app/DropdownWidget.dart';
import 'package:secure_app/crypto-utils.dart';
import 'package:secure_app/customInputContainer%201.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:secure_app/inwardForm%201.dart';
import 'package:secure_app/uploadProposal.dart';

class KYCIndividual extends StatefulWidget {
  final inwardData;
  final inwardType;
  const KYCIndividual(
      {super.key, required this.inwardData, required this.inwardType});

  @override
  State<KYCIndividual> createState() => _KYCIndividualState();
}

class _KYCIndividualState extends State<KYCIndividual> {
  File? galleryFile;
  final picker = ImagePicker();
  String? _modeOfSubmission;
  // String _modeOfSubmission1 = '';
  // String _modeOfSubmission2 = '';
  // String _gender = '';
  // String _member = '';
  String? selectedValue;
  String? selectedDocument;
  String? selectedAddress;

  final controller1 = TextEditingController();
  String birthDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> documents = <String>[
    'PAN Card',
    'Form 60',
    'Form 61',
  ];

  List<String> address = <String>[
    'Voter ID',
    'Passport',
    'Driving License',
    'Masked Aadhar'
  ];
  var _accessToken = '';
  bool isFetched = false;
  TextEditingController panNumberController = TextEditingController();
  Dio dio = DioSingleton.dio;

  void initState() {
    super.initState();
    // getToken();
    // fetchCKYC();
  }

  getToken() async {
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "X-IBM-Client-Id": "03d37cba-bb30-42ef-a7b5-90eff137e085",
      "X-IBM-Client-Secret":
          "aE0fW4iF6sJ0dF0vR5qT1jO3oL3bK5gI6lL1mF2vP1jF4yH3hE"
    };
    try {
      final response = await dio.get('  https://devapi.sbigeneral.in/v1/tokens',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        _accessToken = data['token'];
      }
    } catch (e) {}
  }

  fetchCKYC() async {
    Map<String, dynamic> post = {
      "A99RequestData": {
        "RequestId": "GROMO1718086711165",
        "source": "gromoinsure",
        "policyNumber": "",
        "GetRecordType": "IND",
        "InputIdType": "C",
        "InputIdNo": "BPCPB4053E",
        "DateOfBirth": "10-06-1994",
        "MobileNumber": "",
        "Pincode": "",
        "BirthYear": "",
        "Tags": "",
        "ApplicationRefNumber": "",
        "FirstName": "",
        "MiddleName": "",
        "LastName": "",
        "Gender": "",
        "ResultLimit": "Latest",
        "photo": "",
        "AdditionalAction": ""
      }

      // {
      //   "A99RequestData": {
      //     "RequestId": "A9901",
      //     "source": "SOA",
      //     "policyNumber": "",
      //     "GetRecordType": "IND",
      //     "InputIdType": "C",
      //     "InputIdNo": "BJDPK1684F",
      //     "DateOfBirth": "11-02-1990",
      //     "MobileNumber": "",
      //     "Pincode": "",
      //     "BirthYear": "",
      //     "Tags": "",
      //     "ApplicationRefNumber": "",
      //     "FirstName": "",
      //     "MiddleName": "",
      //     "LastName": "",
      //     "Gender": "",
      //     "ResultLimit": "Latest",
      //     "photo": "",
      //     "AdditionalAction": ""
      //   }
      // "source": "gromoinsure",
      // "policyNumber": "",
      // "GetRecordType": "IND",
      // "InputIdType": "C",
      // "InputIdNo": panNumberController.text,
      // "DateOfBirth": birthDate,
    };
    String key = 'CQuYCxIVNyTOt487084UPBMxhS0XxRE4';
    String base64iv = 'w6tmvKzUj6Rg';
    String result = aesGcmEncryptJson(jsonEncode(post), key, base64iv);

    print(result);
    // Map<String, dynamic> postData = {
    //   "encryptedData": result,
    //   "key": key,
    //   "base64IV": base64iv,
    // };

    // Map<String, dynamic> headers = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   "Accept": "application/json",
    //   "X-IBM-Client-Id": "03d37cba-bb30-42ef-a7b5-90eff137e085",
    //   "X-IBM-Client-Secret":
    //       "aE0fW4iF6sJ0dF0vR5qT1jO3oL3bK5gI6lL1mF2vP1jF4yH3hE",
    //   "Authorization": 'Bearer ${_accessToken}'
    // };
    // try {
    //   final response = await dio.post(
    //       'https://devapi.sbigeneral.in/ept/v1/portalCkycV',
    //       data: postData,
    //       options: Options(headers: headers));
    //   var decryptedData = aesGcmDecryptJson(response.data, key, base64iv);
    //   final Map<String, dynamic> data = jsonDecode(decryptedData);
    // } catch (e) {}
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
            'KYC Module',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
                child: Column(children: [
              const Wrap(spacing: 2, children: [
                Text(
                  'CKYC Available?* ',
                  maxLines: 5,
                  style: TextStyle(
                      color: Color.fromRGBO(11, 133, 163, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '(W.e.f 01st January 2023, CKYC ID creation is mandatory for all the policies at the time of Inception of risk for both Individual and Organization Customers) ',
                  maxLines: 6,
                  style: TextStyle(
                    color: Color.fromRGBO(11, 133, 163, 1),
                    fontSize: 11,
                  ),
                ),
              ]),
              Row(
                children: [
                  Radio(
                    activeColor: const Color.fromRGBO(13, 154, 189, 1),
                    autofocus: false,
                    value: 'Yes',
                    groupValue: _modeOfSubmission,
                    onChanged: (value) {
                      setState(() {
                        _modeOfSubmission = value;
                      });
                    },
                  ),
                  const Text('Yes'),
                  Radio(
                    activeColor: const Color.fromRGBO(13, 154, 189, 1),
                    autofocus: false,
                    value: 'No',
                    groupValue: _modeOfSubmission,
                    onChanged: (value) {
                      setState(() {
                        _modeOfSubmission = value;
                      });
                    },
                  ),
                  const Text('No'),
                ],
              ),
              _heightGap(),
              CustomInputContainer(children: [
                DatePickerFormField(
                  labelText: 'Date of Birth',
                  onChanged: (DateTime? value) {
                    setState(() {
                      birthDate =
                          DateFormat('yyyy-MM-dd').format(value as DateTime);
                    });

                    print('Selected date: $value');
                  },
                  date: birthDate,
                ),
              ]),
              _heightGap(),
              _modeOfSubmission == 'Yes'
                  ? Column(
                      children: [
                        CustomInputField(
                          controller: controller1,
                          title: 'CKYC ID',
                          hintText: 'Enter CKYC ID',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter the CKYC ID';
                            } else if (int.parse(value) == 0) {
                              return 'Please Enter valid CKYC ID';
                            }
                            return null;
                          },
                        ),
                        _heightGap(),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromRGBO(11, 133, 163, 1),
                          ),
                          child: TextButton(
                              onPressed: () {
                                print('done');
                                if (controller1.text == '12345671234567' &&
                                    birthDate == '1990-04-12') {
                                  setState(() {
                                    isFetched = true;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid CKYC ID!')),
                                  );
                                }
                              },
                              child: const Text(
                                'Fetch CKYC Details',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )
                  : Container(),
              _heightGap(),
              _heightGap(),
              _heightGap(),
              isFetched
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromRGBO(11, 133, 163, 1),
                                  width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _heightGap(),
                              _text('Customer Name: Test User'),
                              _heightGap(),
                              _text('CKYC ID: 12345671234567'),
                              _heightGap(),
                              _text('DOB: 12-04-1990'),
                              _heightGap(),
                            ],
                          ),
                        ),
                        _heightGap(),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromRGBO(11, 133, 163, 1),
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProposalDocuments(
                                            inwardData: widget.inwardData,
                                            inwardType: widget.inwardType)));
                              },
                              child: const Text(
                                'Submit CKYC',
                                style: TextStyle(color: Colors.white),
                              )),
                        )
                      ],
                    )
                  : Container()

              // _modeOfSubmission == 'No'
              //     ? Column(
              //         children: [
              //           _customRadio('Do you have PAN?', _modeOfSubmission1,
              //               (value) {
              //             setState(() {
              //               _modeOfSubmission1 = value;
              //             });
              //           }),
              //           _heightGap(),
              //           _modeOfSubmission1 == 'Yes'
              //               ? Column(
              //                   children: [
              //                     CustomInputField(
              //                       controller: panNumberController,
              //                       title: 'PAN Number',
              //                       hintText: 'Enter PAN Number',
              //                       validator: (value) {
              //                         if (value!.isEmpty) {
              //                           return 'Please Enter the PAN Number';
              //                         } else if (int.parse(value) == 0) {
              //                           return 'Please Enter valid PAN Number';
              //                         }
              //                         return null;
              //                       },
              //                     ),
              //                     _heightGap(),
              //                     Container(
              //                       decoration: const BoxDecoration(
              //                         borderRadius:
              //                             BorderRadius.all(Radius.circular(10)),
              //                         color: Color.fromRGBO(11, 133, 163, 1),
              //                       ),
              //                       child: TextButton(
              //                           onPressed: () {},
              //                           child: const Text(
              //                             'Fetch CKYC Details',
              //                             style: TextStyle(color: Colors.white),
              //                           )),
              //                     )
              //                   ],
              //                 )
              //               : Container(),
              // _modeOfSubmission1 == 'No'
              //     ? Column(
              //         children: [
              //           _customRadio('Do you have Aadhar Card?',
              //               _modeOfSubmission2, (value) {
              //             setState(() {
              //               _modeOfSubmission2 = value;
              //             });
              //           }),
              //           _heightGap(),
              //           _modeOfSubmission2 == 'Yes'
              //               ? Column(
              //                   children: [
              //                     CustomInputField(
              //                       title:
              //                           'Enter Last 4 digits of Aadhar Number',
              //                       hintText:
              //                           'Enter Last 4 digits of Aadhar Number',
              //                       validator: (value) {
              //                         if (value!.isEmpty) {
              //                           return 'Please Enter the Aadhar Card Number';
              //                         } else if (int.parse(value) ==
              //                             0) {
              //                           return 'Please Enter valid Aadhar Card Number';
              //                         }
              //                         return null;
              //                       },
              //                     ),
              //                     _heightGap(),
              //                     _heightGap(),
              //                     const CustomInputField(
              //                       title:
              //                           'Customer Full Name as per Aadhar Card',
              //                       hintText:
              //                           'Enter Customer Full Name as per Aadhar Card',
              //                     ),
              //                     _heightGap(),
              //                     _customRadio2('Gender:', _gender,
              //                         (value) {
              //                       setState(() {
              //                         _gender = value;
              //                       });
              //                     }, 'Male', 'Female', 'Transgender'),
              //                     _heightGap(),
              //                     Container(
              //                       decoration: const BoxDecoration(
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(10)),
              //                         color: Color.fromRGBO(
              //                             11, 133, 163, 1),
              //                       ),
              //                       child: TextButton(
              //                           onPressed: () {},
              //                           child: const Text(
              //                             'Fetch CKYC Details',
              //                             style: TextStyle(
              //                                 color: Colors.white),
              //                           )),
              //                     )
              //                   ],
              //                 )
              //               : Container(),
              //           _modeOfSubmission2 == 'No'
              //               ? Column(
              //                   children: [
              //                     _customRadio2(
              //                         'Family Details:', _member,
              //                         (value) {
              //                       setState(() {
              //                         _member = value;
              //                       });
              //                     },
              //                         'Spouse \nDetails',
              //                         "Father's \nDetails",
              //                         "Mother's \nDetails"),
              //                     _heightGap(),
              //                     _member == 'Spouse \nDetails' ||
              //                             _member ==
              //                                 "Father's \nDetails" ||
              //                             _member ==
              //                                 "Mother's \nDetails"
              //                         ? Column(
              //                             children: [
              //                               const CustomInputField(
              //                                 title: 'Salutation',
              //                                 hintText:
              //                                     'Enter Salutation',
              //                               ),
              //                               _nameDetails(),
              //                               _ckycDocuments(),
              //                               _addressProof(),
              //                             ],
              //                           )
              //                         : Container(),
              //                     Container(
              //                       decoration: const BoxDecoration(
              //                         borderRadius: BorderRadius.all(
              //                             Radius.circular(10)),
              //                         color: Color.fromRGBO(
              //                             11, 133, 163, 1),
              //                       ),
              //                       child: TextButton(
              //                           onPressed: () {},
              //                           child: const Text(
              //                             'Submit CKYC',
              //                             style: TextStyle(
              //                                 color: Colors.white),
              //                           )),
              //                     ),
              //                     _heightGap(),
              //                   ],
              //                 )
              //               : Container(),
              //     ],
              //   )
              // : Container(),
              //     ],
              //   )
              // : Container(),
              // _heightGap(),
            ]))));
  }

  _heightGap() {
    return const SizedBox(height: 10);
  }

  _customRadio(String label, mode, onChanged) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Color.fromRGBO(11, 133, 163, 1),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Radio(
                activeColor: const Color.fromRGBO(13, 154, 189, 1),
                value: 'Yes',
                autofocus: false,
                groupValue: mode,
                onChanged: onChanged,
              ),
              const Text('Yes'),
              Radio(
                activeColor: const Color.fromRGBO(13, 154, 189, 1),
                value: 'No',
                autofocus: false,
                groupValue: mode,
                onChanged: onChanged,
              ),
              const Text('No'),
            ],
          ),
        ]);
  }

  _customRadio2(String label, mode, onChanged, String option1, String option2,
      String option3) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Color.fromRGBO(11, 133, 163, 1),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          ),
          _heightGap(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: const Color.fromRGBO(13, 154, 189, 1),
                    value: option1,
                    autofocus: false,
                    groupValue: mode,
                    onChanged: onChanged,
                  ),
                  Text(option1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: const Color.fromRGBO(13, 154, 189, 1),
                    value: option2,
                    autofocus: false,
                    groupValue: mode,
                    onChanged: onChanged,
                  ),
                  Text(option2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: const Color.fromRGBO(13, 154, 189, 1),
                    value: option3,
                    autofocus: false,
                    groupValue: mode,
                    onChanged: onChanged,
                  ),
                  Text(option3),
                ],
              ),
            ],
          ),
        ]);
  }

  _uploadDocument() {
    return Container(
      height: 120.0,
      width: 140.0,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: const Color.fromRGBO(13, 154, 189, 1), width: 2)),
      child: galleryFile == null
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  backgroundColor: const Color.fromARGB(169, 235, 234, 234)),
              child: const Text(
                'Upload\nDocument',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color.fromRGBO(11, 133, 163, 1),
                ),
              ),
              onPressed: () {
                _showPicker(context: context);
              },
            )
          : Center(child: Image.file(galleryFile!)),
    );
  }

  _nameDetails() {
    return Column(
      children: [
        _heightGap(),
        const CustomInputField(
          title: 'First Name',
          hintText: 'Enter First Name',
        ),
        _heightGap(),
        const CustomInputField(
          title: 'Middle Name',
          hintText: 'Enter Middle Name',
        ),
        _heightGap(),
        const CustomInputField(
          title: 'Last Name',
          hintText: 'Enter Last Name',
        ),
      ],
    );
  }

  _ckycDocuments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heightGap(),
        const Text(
          'CKYC Documents:',
          style: TextStyle(
              color: Color.fromRGBO(11, 133, 163, 1),
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        _heightGap(),
        _customDropDown('Select ID Proof', (value) {
          setState(() {
            selectedDocument = value;
          });
        }, documents, selectedDocument),
        _heightGap(),
        selectedDocument == 'PAN Card' ||
                selectedDocument == 'Form 60' ||
                selectedDocument == 'Form 61'
            ? _uploadDocument()
            : Container(),
      ],
    );
  }

  _addressProof() {
    return Column(
      children: [
        _heightGap(),
        _customDropDown('Select Address Proof', (value) {
          setState(() {
            selectedAddress = value;
          });
        }, address, selectedAddress),
        _heightGap(),
        selectedAddress == 'Voter ID'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                      'Voter ID (please upload first and last page of the Voter ID)'),
                  _heightGap(),
                  const CustomInputField(
                    title: 'Voter ID',
                    hintText: 'Enter Voter ID',
                  ),
                  _heightGap(),
                  _uploadDocument()
                ],
              )
            : Container(),
        selectedAddress == 'Passport'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                      'Passport (please upload first and last page of the Passport)'),
                  _heightGap(),
                  const CustomInputField(
                    title: 'Passport Number',
                    hintText: 'Enter Passport Number',
                  ),
                  _heightGap(),
                  _uploadDocument()
                ],
              )
            : Container(),
        selectedAddress == 'Driving License'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heightGap(),
                  const CustomInputField(
                    title: 'Driving License',
                    hintText: 'Enter Driving License',
                  ),
                  _heightGap(),
                  _uploadDocument()
                ],
              )
            : Container(),
        selectedAddress == 'Masked Aadhar'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _text(
                      'Masked Aadhar (please upload front and back side of the Masked Aadhar)'),
                  _heightGap(),
                  const CustomInputField(
                    title: 'Enter Last 4-Digit of Aadhar Card',
                    hintText: 'Enter Last 4-Digit of Aadhar Card',
                  ),
                  _heightGap(),
                  _uploadDocument()
                ],
              )
            : Container(),
        _heightGap()
      ],
    );
  }

  _text(text) {
    return Text(
      text,
      style: const TextStyle(
          color: Color.fromRGBO(11, 133, 163, 1),
          fontSize: 13,
          fontWeight: FontWeight.bold),
    );
  }

  _customDropDown(String hint, onChanged, items, value) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownWidget(
            items: items,
            value: value,
            onChanged: onChanged,
            hintText: hint,
          )
        ]);
  }

  void _showPicker({
    required BuildContext context,
  }) {
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
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
