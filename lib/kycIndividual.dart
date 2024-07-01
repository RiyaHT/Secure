import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:secure_app/DatePickerFormField.dart';
import 'package:secure_app/DropdownWidget.dart';
import 'package:secure_app/crypto-utils.dart';
import 'package:secure_app/customInputContainer%201.dart';
import 'package:secure_app/dioSingleton.dart';
import 'package:secure_app/inwardForm%201.dart';
import 'package:secure_app/uploadProposal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KYCIndividual extends StatefulWidget {
  final inwardData;
  final inwardType;
  const KYCIndividual(
      {super.key, required this.inwardData, required this.inwardType});

  @override
  State<KYCIndividual> createState() => _KYCIndividualState();
}

class _KYCIndividualState extends State<KYCIndividual> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  File? galleryFile;
  final picker = ImagePicker();
  String? _modeOfSubmission;
  String? _modeOfSubmission1;
  String? _modeOfSubmission2;
  String? _gender;
  String? _member;
  String? selectedValue;
  String? selectedDocument;
  String? selectedAddress;
  Map<String, List> kycDocumnet = {'idProof': [], 'addressProof': []};

  String birthDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
  // var _accessToken = '';
  bool isFetched = false;
  bool isSubmitted = false;
  bool fetchKYC = true;
  TextEditingController panNumberController = TextEditingController();
  TextEditingController ckycIDController = TextEditingController();
  TextEditingController adhaarNumberController = TextEditingController();
  TextEditingController adhaarNameController = TextEditingController();
  TextEditingController salutationController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController idProofController = TextEditingController();
  TextEditingController addressProofController = TextEditingController();
  String inputType = '';
  String inputNo = '';
  Dio dio = DioSingleton.dio;
  Map ckycData = {
    "ckycData": {"CKYCNumber": "", "CKYCFullName": "", "CKYCDOB": ""}
  };
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void initState() {
    super.initState();
    // getToken();
    // fetchCKYC();
  }

  resetVariable() {
    setState(() {
      _modeOfSubmission1 = null;
      _modeOfSubmission2 = null;
      _gender = null;
      birthDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      panNumberController = TextEditingController();
      ckycIDController = TextEditingController();
      adhaarNumberController = TextEditingController();
      adhaarNameController = TextEditingController();
      salutationController = TextEditingController();
      firstNameController = TextEditingController();
      middleNameController = TextEditingController();
      lastNameController = TextEditingController();
      idProofController = TextEditingController();
      addressProofController = TextEditingController();
    });
    // String _member = '';
  }

  // getToken() async {
  //   Map<String, dynamic> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Accept": "application/json",
  //     "X-IBM-Client-Id": "03d37cba-bb30-42ef-a7b5-90eff137e085",
  //     "X-IBM-Client-Secret":
  //         "aE0fW4iF6sJ0dF0vR5qT1jO3oL3bK5gI6lL1mF2vP1jF4yH3hE"
  //   };
  //   try {
  //     final response = await dio.get('  https://devapi.sbigeneral.in/v1/tokens',
  //         options: Options(headers: headers));
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.data);
  //       _accessToken = data['token'];
  //     }
  //   } catch (e) {}
  // }

  fetchCKYC() async {
    String firstName = '';
    String middleName = '';
    String lastName = '';
    var adhaarNameValue = adhaarNameController.text.split(' ');
    if (adhaarNameValue.length == 3) {
      firstName = adhaarNameValue[0];
      middleName = adhaarNameValue[1];
      lastName = adhaarNameValue[2];
    }
    if (adhaarNameValue.length == 2) {
      firstName = adhaarNameValue[0];
      lastName = adhaarNameValue[1];
    }
    if (adhaarNameValue.length == 1) {
      firstName = adhaarNameValue[0];
    }

    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token') ?? '';
    Map<String, dynamic> kycData = {
      "A99RequestData": {
        "RequestId": "ITSECURE${DateTime.now().millisecondsSinceEpoch}",
        "source": "gromoinsure",
        "policyNumber": "",
        "GetRecordType": "IND",
        "InputIdType": inputType,
        "InputIdNo": inputNo,
        "DateOfBirth": birthDate,
        "MobileNumber": "",
        "Pincode": "",
        "BirthYear": "",
        "Tags": "",
        "ApplicationRefNumber": "",
        "FirstName": firstName,
        "MiddleName": middleName,
        "LastName": lastName,
        "Gender": "",
        "ResultLimit": "Latest",
        "photo": "",
        "AdditionalAction": ""
      }
    };

    print(kycData);

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Authorization": token
    };
    try {
      final response = await dio.post(
          'https://uatcld.sbigeneral.in/SecureApp/ckyc',
          data: kycData,
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.data);
        setState(() {
          isFetched = true;
          ckycData = data;
          isLoading = false;
          isSubmitted = true;
          fetchKYC = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        fetchKYC = true;
        isFetched = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("No Records Found!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }

  void _submitKYC() {
    Map kycData = {
      "ckyc_num": ckycIDController.text,
      "customer_type": "Individual",
      "pan_num": panNumberController.text,
      "dob": '',
      "aadhar_card_last_4_digit_number": adhaarNumberController.text,
      "aadhar_card_full_name": adhaarNameController.text,
      "aadhar_card_gender": _gender,
      "aadhar_card_dob": '',
      "relative_type_selected": _member,
      "relative_prefix": salutationController.text,
      "relative_first_name": firstNameController.text,
      "relative_middle_name": middleNameController.text,
      "relative_last_name": lastNameController.text,
      "doc_addr_proof_number": addressProofController.text,
      "response_ckyc_num": ckycData['ckycData']['CKYCFullName'],
      "response_ckyc_dob	date": ckycData['ckycData']['CKYCNumber'],
      "response_ckyc_customer_name": ckycData['ckycData']['CKYCDOB']
    };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProposalDocuments(
                inwardData: widget.inwardData,
                inwardType: widget.inwardType,
                ckycData: kycData,
                ckycDocuments:
                    kycDocumnet['idProof']! + kycDocumnet['addressProof']!)));
  }

  // fetchCKYC() async {
  //   Map<String, dynamic> post = {};

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
                'KYC Module',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(13, 154, 189, 1),
              titleTextStyle: const TextStyle(color: Colors.white),
            ),
            body: Form(
              key: _formKey,
              child: Container(
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
                            if (_modeOfSubmission != value) {
                              resetVariable();
                            }
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
                            if (_modeOfSubmission != value) {
                              resetVariable();
                            }
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
                            birthDate = DateFormat('dd-MM-yyyy')
                                .format(value as DateTime);
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
                                controller: ckycIDController,
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
                              fetchKYC
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(11, 133, 163, 1),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            print('done');
                                            if (_modeOfSubmission != null) {
                                              setState(() {
                                                inputType = 'Z';
                                                inputType =
                                                    ckycIDController.text;
                                              });
                                              fetchCKYC();
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Please enter valid details!')),
                                              );
                                            }
                                          },
                                          child: const Text(
                                            'Fetch CKYC Details',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    )
                                  : Container()
                            ],
                          )
                        : Container(),
                    // _heightGap(),
                    // _heightGap(),
                    // _heightGap(),

                    _modeOfSubmission == 'No'
                        ? Column(
                            children: [
                              _customRadio(
                                  'Do you have PAN?', _modeOfSubmission1,
                                  (value) {
                                if (_modeOfSubmission1 != value) {
                                  setState(() {
                                    _modeOfSubmission2 = null;
                                    _gender = null;
                                    birthDate = DateFormat('dd-MM-yyyy')
                                        .format(DateTime.now());
                                    panNumberController =
                                        TextEditingController();
                                    ckycIDController = TextEditingController();
                                    adhaarNumberController =
                                        TextEditingController();
                                    adhaarNameController =
                                        TextEditingController();
                                    salutationController =
                                        TextEditingController();
                                    firstNameController =
                                        TextEditingController();
                                    middleNameController =
                                        TextEditingController();
                                    lastNameController =
                                        TextEditingController();
                                    idProofController = TextEditingController();
                                    addressProofController =
                                        TextEditingController();
                                  });
                                }
                                setState(() {
                                  _modeOfSubmission1 = value;
                                });
                              }),
                              _heightGap(),
                              _modeOfSubmission1 == 'Yes'
                                  ? Column(
                                      children: [
                                        CustomInputField(
                                          controller: panNumberController,
                                          title: 'PAN Number',
                                          hintText: 'Enter PAN Number',
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Please Enter the PAN Number';
                                          //   } else if (int.parse(value) == 0) {
                                          //     return 'Please Enter valid PAN Number';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                        _heightGap(),
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color:
                                                Color.fromRGBO(11, 133, 163, 1),
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                print('done');
                                                if (_modeOfSubmission1 !=
                                                        null &&
                                                    _formKey.currentState!
                                                        .validate()) {
                                                  setState(() {
                                                    inputType = 'C';
                                                    inputNo =
                                                        panNumberController
                                                            .text;
                                                  });
                                                  fetchCKYC();
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Please enter valid details!')),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'Fetch CKYC Details',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )
                                      ],
                                    )
                                  : Container(),
                              _modeOfSubmission1 == 'No'
                                  ? Column(
                                      children: [
                                        _customRadio('Do you have Aadhar Card?',
                                            _modeOfSubmission2, (value) {
                                          if (_modeOfSubmission2 != value) {
                                            setState(() {
                                              _modeOfSubmission2 = null;
                                              _gender = null;
                                              birthDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.now());
                                              panNumberController =
                                                  TextEditingController();
                                              ckycIDController =
                                                  TextEditingController();
                                              adhaarNumberController =
                                                  TextEditingController();
                                              adhaarNameController =
                                                  TextEditingController();
                                              salutationController =
                                                  TextEditingController();
                                              firstNameController =
                                                  TextEditingController();
                                              middleNameController =
                                                  TextEditingController();
                                              lastNameController =
                                                  TextEditingController();
                                              idProofController =
                                                  TextEditingController();
                                              addressProofController =
                                                  TextEditingController();
                                            });
                                          }
                                          setState(() {
                                            _modeOfSubmission2 = value;
                                          });
                                        }),
                                        _heightGap(),
                                        _modeOfSubmission2 == 'Yes'
                                            ? Column(
                                                children: [
                                                  CustomInputField(
                                                    controller:
                                                        adhaarNumberController,
                                                    title:
                                                        'Enter Last 4 digits of Aadhar Number',
                                                    hintText:
                                                        'Enter Last 4 digits of Aadhar Number',
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Please Enter the Aadhar Card Number';
                                                      } else if (int.parse(
                                                              value) ==
                                                          0) {
                                                        return 'Please Enter valid Aadhar Card Number';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  _heightGap(),
                                                  _heightGap(),
                                                  CustomInputField(
                                                    controller:
                                                        adhaarNameController,
                                                    title:
                                                        'Customer Full Name as per Aadhar Card',
                                                    hintText:
                                                        'Enter Customer Full Name as per Aadhar Card',
                                                  ),
                                                  _heightGap(),
                                                  _customRadio2(
                                                      'Gender:', _gender,
                                                      (value) {
                                                    setState(() {
                                                      _gender = value;
                                                    });
                                                  }, 'Male', 'Female',
                                                      'Transgender'),
                                                  _heightGap(),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Color.fromRGBO(
                                                          11, 133, 163, 1),
                                                    ),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          print('done');
                                                          if (_modeOfSubmission2 !=
                                                                  null &&
                                                              _gender != null) {
                                                            setState(() {
                                                              inputType = 'E';
                                                              inputNo =
                                                                  adhaarNumberController
                                                                      .text;
                                                            });
                                                            fetchCKYC();
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Please enter valid details!')),
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Fetch CKYC Details',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  )
                                                ],
                                              )
                                            : Container(),
                                        _modeOfSubmission2 == 'No'
                                            ? Column(
                                                children: [
                                                  _customRadio2(
                                                      'Family Details:',
                                                      _member, (value) {
                                                    setState(() {
                                                      _member = value;
                                                    });
                                                  },
                                                      'Spouse \nDetails',
                                                      "Father's \nDetails",
                                                      "Mother's \nDetails"),
                                                  _heightGap(),
                                                  _member == 'Spouse \nDetails' ||
                                                          _member ==
                                                              "Father's \nDetails" ||
                                                          _member ==
                                                              "Mother's \nDetails"
                                                      ? Column(
                                                          children: [
                                                            CustomInputField(
                                                              controller:
                                                                  salutationController,
                                                              title:
                                                                  'Salutation',
                                                              hintText:
                                                                  'Enter Salutation',
                                                            ),
                                                            _nameDetails(),
                                                            _ckycDocuments(),
                                                            _addressProof(),
                                                          ],
                                                        )
                                                      : Container(),
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Color.fromRGBO(
                                                          11, 133, 163, 1),
                                                    ),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          _submitKYC();
                                                        },
                                                        child: const Text(
                                                          'Submit CKYC',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )),
                                                  ),
                                                  _heightGap(),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Container(),
                            ],
                          )
                        : Container(),
                    _heightGap(),
                    isFetched
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _heightGap(),
                              _heightGap(),
                              _heightGap(),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            11, 133, 163, 1),
                                        width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _heightGap(),
                                    _text(
                                        'Customer Name: ${ckycData['ckycData']['CKYCFullName']}'),
                                    _heightGap(),
                                    _text(
                                        'CKYC ID: ${ckycData['ckycData']['CKYCNumber']}'),
                                    _heightGap(),
                                    _text(
                                        'DOB: ${ckycData['ckycData']['CKYCDOB']}'),
                                    _heightGap(),
                                  ],
                                ),
                              ),
                              _heightGap(),
                              isSubmitted
                                  ? Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color.fromRGBO(11, 133, 163, 1),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            _submitKYC();
                                          },
                                          child: const Text(
                                            'Submit CKYC',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    )
                                  : Container()
                            ],
                          )
                        : Container(),
                  ]))),
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
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
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

  _nameDetails() {
    return Column(
      children: [
        _heightGap(),
        CustomInputField(
          controller: firstNameController,
          title: 'First Name',
          hintText: 'Enter First Name',
        ),
        _heightGap(),
        CustomInputField(
          controller: middleNameController,
          title: 'Middle Name',
          hintText: 'Enter Middle Name',
        ),
        _heightGap(),
        CustomInputField(
          controller: lastNameController,
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
            ? _uploadDocument('Upload\nIdentity\nProof', 0, 'idProof')
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
                  CustomInputField(
                    controller: addressProofController,
                    title: 'Voter ID',
                    hintText: 'Enter Voter ID',
                  ),
                  _heightGap(),
                  _uploadDocument('Upload\nAddress\nProof', 0, 'addressProof')
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
                  CustomInputField(
                    controller: addressProofController,
                    title: 'Passport Number',
                    hintText: 'Enter Passport Number',
                  ),
                  _heightGap(),
                  _uploadDocument('Upload\nAddress\nProof', 0, 'addressProof')
                ],
              )
            : Container(),
        selectedAddress == 'Driving License'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heightGap(),
                  CustomInputField(
                    controller: addressProofController,
                    title: 'Driving License',
                    hintText: 'Enter Driving License',
                  ),
                  _heightGap(),
                  _uploadDocument('Upload\nAddress\nProof', 0, 'addressProof')
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
                  CustomInputField(
                    controller: addressProofController,
                    title: 'Enter Last 4-Digit of Aadhar Card',
                    hintText: 'Enter Last 4-Digit of Aadhar Card',
                  ),
                  _heightGap(),
                  _uploadDocument('Upload\nAddress\nProof', 0, 'addressProof')
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
          child: kycDocumnet[type]!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: kycDocumnet[type]![index].path.endsWith('.pdf')
                        ? PDFView(
                            filePath: kycDocumnet[type]![index].path,
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: false,
                            pageSnap: true,
                          )
                        : Image.file(kycDocumnet[type]![index]),
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
        kycDocumnet[type]!.length > index
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
                      kycDocumnet[type]!.removeAt(index);
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
        if (kycDocumnet[type]!.length > index) {
          kycDocumnet[type]![index] = File(result.files.single.path!);
        } else {
          kycDocumnet[type]!.add(File(result.files.single.path!));
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
        if (kycDocumnet[type]!.length > index) {
          kycDocumnet[type]![index] = File(pickedFile.path);
        } else {
          kycDocumnet[type]!.add(File(pickedFile.path));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No document selected')),
      );
    }
  }
}
