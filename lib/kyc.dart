import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:secure_app/DatePickerFormField.dart';
import 'package:secure_app/DropdownWidget.dart';
import 'package:secure_app/customInputContainer%201.dart';
import 'package:secure_app/uploadProposal.dart';

class KYCForm extends StatefulWidget {
  const KYCForm({super.key});

  @override
  State<KYCForm> createState() => _KYCFormState();
}

class _KYCFormState extends State<KYCForm> {
  String? _modeOfSubmission;
  String _modeOfSubmission1 = '';
  String _modeOfSubmission2 = '';
  String? selectedValue;
  String? selectedDocument;
  String? selectedIdentity;
  String? selectedIdentity2;
  String? selectedIdentity3;
  String? selectedIdentity4;
  String? selectedIdentity5;
  String? selectedIdentity6;
  String? selectedIdentity7;
  String? selectedAddress;
  String incorporationDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final controller1 = TextEditingController();
  bool isFetched = false;
  File? _pdfFile;
  List<String> entity = <String>[
    'Sole Proprietorship',
    'Partnership Firm',
    'HUF',
    'Private Limited Company',
    'Public Limited Company',
    'Society',
    'Association of Persons',
    'Trust',
    'Liquidator',
    'Limited Liability Partnership',
    'Artificial Liability Partnership',
    'Public Sector Banks',
    'Central/ State Gov Dept',
    'Section 8 Companies',
    'Artificial Jurisdical Person',
    'International Organisation/ Agency',
    'Not Categorized',
    'Foreign Portfolio Investors',
    'Others'
  ];

  List<String> documents = <String>[
    'PAN Card',
    'Form 60',
  ];
  List<String> identity1 = <String>[
    'Registration Certificate',
    'Activity Proof-1',
    'Activity Proof-2',
  ];
  List<String> identity2 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Registration Certificate',
    'Partnership Deed'
  ];

  List<String> identity3 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Registration Certificate',
  ];

  List<String> identity4 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Certificate of Incorporation/Formation',
    'Registration Certificate',
    'Memorandum and Articles of Association',
    'Board Resolution'
  ];
  List<String> identity5 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Registration Certificate',
    'Partnership Deed',
    'Trust Deed',
    'Board Resolution'
  ];
  List<String> identity6 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Registration Certificate',
    'Trust Deed',
    'Board Resolution'
  ];

  List<String> identity7 = <String>[
    'OVD in respect of person authorized to transact',
    'Power of Atterney granted to Manager',
    'Registration Certificate',
    'Board Resolution'
  ];
  List<String> address1 = <String>['Registration Certificate', 'Others'];
  List<String> address2 = <String>[
    'Certificate of Incorporation/Formation',
    'Registration Certificate',
    'Others'
  ];
  File? galleryFile;
  final picker = ImagePicker();

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
        print(_pdfFile);
      });
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
          child: Column(
            children: [
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
                  labelText: 'Date of Incorporation',
                  onChanged: (DateTime? value) {
                    setState(() {
                      incorporationDate =
                          DateFormat('yyyy-MM-dd').format(value as DateTime);
                    });
                    print('Selected date: $value');
                  },
                  date: incorporationDate,
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
                              return 'Please Enter valid CKYC';
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
                                if (controller1.text == '12345671234567') {
                                  setState(() {
                                    isFetched = true;
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid CKYC ID')),
                                  );
                                }
                              },
                              child: const Text(
                                'Fetch CKYC Details',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        _heightGap(),
                        _heightGap(),
                        _heightGap(),
                        isFetched
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                11, 133, 163, 1),
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _heightGap(),
                                        _text(
                                            'Customer Name: Abcde Fghijklmno'),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromRGBO(11, 133, 163, 1),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProposalDocuments(
                                                          inwardData: {},
                                                          inwardType: {})));
                                        },
                                        child: const Text(
                                          'Submit CKYC',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    )
                  : Container(),
              // _modeOfSubmission == 'No'
              //     ? Column(
              //         children: [
              //           _heightGap(),
              //           _customRadio('Do you have PAN?', _modeOfSubmission1,
              //               (value) {
              //             setState(() {
              //               _modeOfSubmission1 = value;
              //             });
              //           }),
              //           _modeOfSubmission1 == 'Yes'
              //               ? Column(
              //                   children: [
              //                     CustomInputField(
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
              //           _modeOfSubmission1 == 'No'
              //               ? Column(
              //                   children: [
              //                     _customRadio('Do you have Company ID Number?',
              //                         _modeOfSubmission2, (value) {
              //                       setState(() {
              //                         _modeOfSubmission2 = value;
              //                       });
              //                     }),
              //                     _modeOfSubmission2 == 'Yes'
              //                         ? Column(
              //                             children: [
              //                               CustomInputField(
              //                                 title: 'CIN',
              //                                 hintText: 'Enter CIN',
              //                                 validator: (value) {
              //                                   if (value!.isEmpty) {
              //                                     return 'Please Enter the CIN';
              //                                   } else if (int.parse(value) ==
              //                                       0) {
              //                                     return 'Please Enter valid CIN';
              //                                   }
              //                                   return null;
              //                                 },
              //                               ),
              //                               _heightGap(),
              //                               Container(
              //                                 decoration: const BoxDecoration(
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(10)),
              //                                   color: Color.fromRGBO(
              //                                       11, 133, 163, 1),
              //                                 ),
              //                                 child: TextButton(
              //                                     onPressed: () {},
              //                                     child: const Text(
              //                                       'Fetch CKYC Details',
              //                                       style: TextStyle(
              //                                           color: Colors.white),
              //                                     )),
              //                               )
              //                             ],
              //                           )
              //                         : Container(),
              //                     _modeOfSubmission2 == 'No'
              //                         ? Column(
              //                             children: [
              //                               _customDropDown('Entity Type:',
              //                                   'Select Entity Type', (value) {
              //                                 setState(() {
              //                                   selectedValue = value;
              //                                   print(selectedValue);
              //                                 });
              //                               }, entity, selectedValue),
              //                               _heightGap(),
              //                               selectedValue ==
              //                                           'Sole Proprietorship' ||
              //                                       selectedValue ==
              //                                           'Liquidator'
              //                                   ? _identity1()
              //                                   : Container(),
              //                               selectedValue ==
              //                                           'Partnership Firm' ||
              //                                       selectedValue ==
              //                                           'Limited Liability Partnership' ||
              //                                       selectedValue ==
              //                                           'Artificial Liability Partnership'
              //                                   ? _identity(identity2)
              //                                   : Container(),
              //                               selectedValue == 'HUF' ||
              //                                       selectedValue ==
              //                                           'Associations of Persons'
              //                                   ? _identity(identity3)
              //                                   : Container(),
              //                               selectedValue ==
              //                                           'Private Limited Company' ||
              //                                       selectedValue ==
              //                                           'Public Limited Company' ||
              //                                       selectedValue ==
              //                                           'Section 8 Companies'
              //                                   ? _identity(identity4)
              //                                   : Container(),
              //                               selectedValue == 'Society'
              //                                   ? _identity(identity5)
              //                                   : Container(),
              //                               selectedValue == 'Trust'
              //                                   ? _identity(identity6)
              //                                   : Container(),
              //                               selectedValue ==
              //                                           'Public Sector Banks' ||
              //                                       selectedValue ==
              //                                           'Artificial Jurisdical Person'
              //                                   ? _identity(identity7)
              //                                   : Container(),
              //                               selectedIdentity ==
              //                                           'Activity Proof-1' ||
              //                                       selectedIdentity ==
              //                                           'Activity Proof-2'
              //                                   ? _activityProof()
              //                                   : Container(),
              //                               selectedIdentity ==
              //                                           'OVD in respect of person authorized to transact' ||
              //                                       selectedIdentity ==
              //                                           'Power of Atterney granted to Manager' ||
              //                                       selectedIdentity ==
              //                                           'Partnership Deed'
              //                                   ? _identityDocuments(address2)
              //                                   : Container(),
              //                               selectedIdentity ==
              //                                       'Registration Certificate'
              //                                   ? _registrationCertificate()
              //                                   : Container(),
              //                               selectedIdentity ==
              //                                       'Certificate of Incorporation/Formation'
              //                                   ? _certificate()
              //                                   : Container(),
              //                               _heightGap(),
              //                               Container(
              //                                 decoration: const BoxDecoration(
              //                                   borderRadius: BorderRadius.all(
              //                                       Radius.circular(10)),
              //                                   color: Color.fromRGBO(
              //                                       11, 133, 163, 1),
              //                                 ),
              //                                 child: TextButton(
              //                                     onPressed: () {},
              //                                     child: const Text(
              //                                       'Submit CKYC',
              //                                       style: TextStyle(
              //                                           color: Colors.white),
              //                                     )),
              //                               )
              //                             ],
              //                           )
              //                         : Container(),
              //                   ],
              //                 )
              //               : Container(),
              //           _heightGap(),
              //         ],
              //       )
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _identity(identity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panUpload(),
        _customDropDown('Proof of Identity:', 'Select option', (value) {
          setState(() {
            selectedIdentity = value;
          });
        }, identity, selectedIdentity),
        _heightGap(),
      ],
    );
  }

  _identity1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customDropDown('Select Documents:', 'Select option', (value) {
          setState(() {
            selectedDocument = value;
          });
        }, documents, selectedDocument),
        _heightGap(),
        selectedDocument == 'PAN Card' || selectedDocument == 'Form 60'
            ? _uploadDocument()
            : Container(),
        _heightGap(),
        _customDropDown('Proof of Identity:', 'Select option', (value) {
          setState(() {
            selectedIdentity = value;
          });
        }, identity1, selectedIdentity),
        _heightGap(),
      ],
    );
  }

  _identityDocuments(address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heightGap(),
        _uploadDocument(),
        _heightGap(),
        _addressProof(address)
      ],
    );
  }

  _registrationCertificate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          title: 'Registration Certificate',
          hintText: 'Enter Registration Certificate',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter the Registration Certificate';
            } else if (int.parse(value) == 0) {
              return 'Please Enter valid Registration Certificate';
            }
            return null;
          },
        ),
        _heightGap(),
        _uploadDocument()
      ],
    );
  }

  _certificate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          title: 'Certificate of Incorporation/Formation',
          hintText: 'Enter Company ID Number',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter the Company ID Number';
            } else if (int.parse(value) == 0) {
              return 'Please Enter valid Company ID Number';
            }
            return null;
          },
        ),
        _heightGap(),
        _uploadDocument()
      ],
    );
  }

  _activityProof() {
    return Column(
      children: [_uploadDocument(), _addressProof(address1)],
    );
  }

  _panUpload() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Pan Upload',
        style: TextStyle(
            color: Color.fromRGBO(11, 133, 163, 1),
            fontSize: 13,
            fontWeight: FontWeight.bold),
      ),
      _heightGap(),
      _uploadDocument(),
      _heightGap()
    ]);
  }

  _heightGap() {
    return const SizedBox(height: 10);
  }

  _customRadio(String label, String mode, onChanged) {
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

  _customDropDown(String label, String hint, onChanged, items, value) {
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
          const SizedBox(
            height: 10,
          ),
          DropdownWidget(
            items: items,
            value: value,
            onChanged: onChanged,
            hintText: hint,
          )
        ]);
  }

  _addressProof(address) {
    return Column(
      children: [
        _heightGap(),
        _customDropDown('Proof of Address:', 'Select option', (value) {
          setState(() {
            selectedAddress = value;
          });
        }, address, selectedAddress),
        _heightGap(),
        selectedAddress == 'Registration Certificate'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    title: 'Registration Certificate',
                    hintText: 'Enter Registration Certificate',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the Registration Certificate';
                      } else if (int.parse(value) == 0) {
                        return 'Please Enter valid Registration Certificate';
                      }
                      return null;
                    },
                  ),
                  _heightGap(),
                  _uploadDocument()
                ],
              )
            : Container(),
        selectedAddress == 'Others'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInputField(
                    title: 'Other Document',
                    hintText: 'Enter other Document Nmae',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the Document Name';
                      } else if (int.parse(value) == 0) {
                        return 'Please Enter valid Document Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _uploadDocument()
                ],
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _uploadDocument() {
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
          child: galleryFile == null && _pdfFile == null
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        backgroundColor:
                            const Color.fromARGB(169, 235, 234, 234)),
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
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Center(
                      child: _pdfFile != null
                          ? PDFView(
                              filePath: _pdfFile!.path,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: false,
                              pageSnap: true,
                            )
                          : galleryFile != null
                              ? Image.file(galleryFile!)
                              : Container()),
                ),
        ),
        galleryFile != null || _pdfFile != null
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
                        _pdfFile = null;
                        galleryFile = null;
                      });
                    }),
              )
            : Container()
      ],
    );
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
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text('PDF'),
                onTap: () {
                  _pickPDF();
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

  _text(String text) {
    return Text(
      text,
      maxLines: 3,
      style: const TextStyle(
          color: Color.fromRGBO(11, 133, 163, 1),
          fontSize: 13,
          fontWeight: FontWeight.bold),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final FormFieldValidator? validator;
  final TextEditingController? controller;

  const CustomInputField(
      {super.key, this.title, this.hintText, this.validator, this.controller});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode1 = FocusNode();
    return TextFormField(
      // scrollPadding: EdgeInsets.all(5),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black12, width: 2),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromRGBO(11, 133, 163, 1), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color.fromRGBO(11, 133, 163, 1);
          }
          return Colors.grey;
        }),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
        labelStyle: TextStyle(
            color: focusNode1.hasFocus
                ? const Color.fromRGBO(11, 133, 163, 1)
                : Colors.grey),
        hintText: hintText,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

// / switch (selectedValue) {
//   'Sole Proprietorship' =>
//     _customDropDown('Select Documents', 'Select option', (value) {
//       selectedDocument = value;
//     }, documents, selectedDocument),
// TODO: Handle this case.
// String() => throw UnimplementedError(),
// },
//
// const SizedBox(
//   height: 20,
// ),
// SizedBox(
//   height: 150.0,
//   width: 200.0,
//   child: galleryFile == null
//       ? const Center(child: Text('Sorry nothing selected!!'))
//       : Center(child: Image.file(galleryFile!)),
// ),

