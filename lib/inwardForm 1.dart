// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:secure_app/CustomRadioButton.dart';
import 'package:secure_app/DatePickerFormField.dart';
import 'package:secure_app/DropdownWidget.dart';
import 'package:secure_app/RenderForm.dart';
import 'package:secure_app/commonFunction.dart';
import 'package:secure_app/customInputContainer%201.dart';
import 'package:secure_app/kycIndividual.dart';

// import 'package:secure_app/kyc.dart';
// import 'package:secure_app/kycIndividual.dart';
import 'package:secure_app/uploadProposal.dart';
// import 'package:secure_app/customInputContainer.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> productList = <String>[
    'Advances Loss Of Profit',
    'Agriculture Pumpset Insurance',
    'All Risk Insurance',
    'Arogya Combo'
  ];
  List<String> list = <String>['EFT', 'Cash', 'Cheque', 'Credit Card'];
  List<String> spCodes = <String>['124456', '124452', '124458', '124459'];
  List<String> inwardType = <String>[
    'Proposal',
    'Endorsement',
    'Miscellaneous'
  ];
  List<String> proposalType = <String>[
    'Fresh Proposal',
    'Roll over',
    'Renewal'
  ];
  List<String> branches = <String>['Udaipur', 'Jaipur', 'Mumbai', 'Assam'];
  final List<String> items = [
    '23456',
    '12345',
    '34567',
  ];
  // var dropdownValue = "";
  TextEditingController customerNameController = TextEditingController();
  TextEditingController previousPolicyController = TextEditingController();

  TextEditingController premiumAmountController = TextEditingController();
  TextEditingController instrumentNumberController = TextEditingController();
  TextEditingController instrumentAmountController = TextEditingController();
  TextEditingController salesEmailController = TextEditingController();
  TextEditingController salesMobileController = TextEditingController();
  TextEditingController policyNumberController = TextEditingController();
  TextEditingController quoteNumberController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  String? selectedCode;
  TextEditingController agreementCodeController = TextEditingController();

  String? _inwardType;
  String _modeOfSubmission1 = 'Digital';
  bool isValid = false;

  String instrumentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String proposedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _coInsurance = 'No';
  String _PPHC = 'No';
  String customerType = 'Individual';
  String? leadType;
  String? selectedProduct;
  String? selectedProposal;
  String? selectedSPCode;
  String? selectedBranch;
  String? selectedSBIGBranch;
  String? selectedInstrumentType;
  Map? endorsementData;

  void resetVariables() {
    // var dropdownValue = "";

    setState(() {
      customerNameController = TextEditingController();
      previousPolicyController = TextEditingController();
      premiumAmountController = TextEditingController();
      instrumentNumberController = TextEditingController();
      instrumentAmountController = TextEditingController();
      salesEmailController = TextEditingController();
      salesMobileController = TextEditingController();
      policyNumberController = TextEditingController();
      quoteNumberController = TextEditingController();
      selectedCode = null;
      agreementCodeController = TextEditingController();
      _modeOfSubmission1 = 'Digital';
      instrumentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      proposedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      _coInsurance = 'No';
      _PPHC = 'No';
      customerType = 'Individual';
      leadType = '';
      selectedProduct = null;
      selectedProposal = null;
      selectedSPCode = null;
      selectedBranch = null;
      selectedSBIGBranch = null;
      selectedInstrumentType = null;
    });
  }

  void _submitForm() {
    Map endorsementData2 = {
      "proposalDetails": {
        "is_bulk": 0,
        "final_submitted": 0,
        "inward_type": _inwardType,
        "submission_mode": _modeOfSubmission1,
        "agreement_code": selectedCode,
        "sp_code": '',
        "branch": selectedBranch,
        "sbigi_branch": selectedSBIGBranch,
        "simflo_id": '',
        "customer_name": customerNameController.text,
        "co_insurance": _coInsurance,
        "leader_follower_type": leadType,
        "pphc": _PPHC,
        "premium_amount": premiumAmountController.text,
        "proposer_signed_date": proposedDate,
        "instruments": [
          {
            "instrumentType": selectedInstrumentType,
            "instrumentNumber": instrumentNumberController.text,
            "instrumentAmount": instrumentAmountController.text,
            "instrumentDate": instrumentDate,
          },
        ]
      },
      "endorsementDetails": {
        ...endorsementData!['endorsement'],
        ...{
          //  "endorsement_type":
          //     "sub_type":
          // "product": selectedProduct,

          "email": salesEmailController.text,
          "mobile": salesMobileController.text,
          // "new_value":
          "branch_name": selectedBranch,
          "policy_number": policyNumberController.text,
        }
      },
    };

    Map inwardData = {
      "is_bulk": 0,
      "final_submitted": 0,
      "inward_type": _inwardType,
      "inward_proposal_type": selectedProposal,
      "submission_mode": _modeOfSubmission1,
      "product": selectedProduct,
      "agreement_code": selectedCode,
      "sp_code": '',
      "branch": selectedBranch,
      "sbigi_branch": selectedSBIGBranch,
      "simflo_id": '',
      "customer_name": customerNameController.text,
      "co_insurance": _coInsurance,
      "leader_follower_type": leadType,
      "pphc": _PPHC,
      "premium_amount": premiumAmountController.text,
      "proposer_signed_date": proposedDate,
      "instruments": [
        {
          "instrumentType": selectedInstrumentType,
          "instrumentNumber": instrumentNumberController.text,
          "instrumentAmount": instrumentAmountController.text,
          "instrumentDate": instrumentDate,
        },
      ]
    };
    print(inwardData);
    print(endorsementData2);
    if (_formKey.currentState!.validate()

        // _inwardType == null ||
        //       selectedProduct == null ||
        //       _modeOfSubmission1 == null ||
        //       // selectedSPCode == null ||
        //       selectedBranch == null ||
        //       selectedSBIGBranch == null ||
        //       customerNameController.text.isEmpty ||
        //       _coInsurance == null ||
        //       _PPHC == null ||
        //       // panNumberController.text.isEmpty ||
        //       premiumAmountController.text.isEmpty
        // selectedInstrumentType == null ||
        // instrumentNumberController.text.isEmpty ||
        // instrumentAmountController.text.isEmpty
        // ) {
        // if (selectedCode == '') {
        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //       content: const Text("Please select Agreement Code!"),
        //       action: SnackBarAction(
        //         label: ' Cancel',
        //         onPressed: () {},
        //       )));
        ) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KYCIndividual(
                  inwardData: _inwardType == 'Endorsement'
                      ? endorsementData2
                      : inwardData,
                  inwardType: _inwardType)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Please fill all the mandatory fields!"),
          action: SnackBarAction(
            label: ' Cancel',
            onPressed: () {},
          )));
    }
  }
  // } else {

  // if (_inwardType == 'Endorsement') {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => KYCIndividual(
  //               inwardData: endorsementData, inwardType: _inwardType)));
  // } else {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => KYCIndividual(
  //                 inwardData: inwardData,
  //                 inwardType: _inwardType,
  //               )));
  //   // }
  // }

  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     title: const Text('Error'),
  //     content: const Text('Please fill out all fields'),
  //     actions: [
  //       TextButton(
  //         onPressed: () => Navigator.pop(context),
  //         child: const Text('OK'),
  //       ),
  //     ],
  //   ),
  // );

  // Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => ProposalDocuments(
  //               inwardData: inwardData,
  //             )));
  // if (customerType == 'Individual') {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => const KYCIndividual()));
  // } else if (customerType == 'Other Individual') {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const KYCForm()));
  // }
  // }
  // }

  void initState() {
    super.initState();
    setState(() {
      endorsementData = {'endorsement': {}};
    });
  }

  @override
  void dispose() {
    agreementCodeController.dispose();
    super.dispose();
  }

  getEndorsementValues(Map endorsementDetails) {
    Map<String, dynamic> combinedMap = {
      ...endorsementData!['endorsement'],
      ...endorsementDetails
    };
    setState(() {
      endorsementData!['endorsement'] = combinedMap;
    });
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
          'Create Inward Form',
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputContainer(children: [
                      DropdownWidget(
                        label: 'Inward Type',
                        items: inwardType,
                        hintText: "Please Select Inward Type",
                        value: _inwardType,
                        onChanged: (val) {
                          if (val != _inwardType) {
                            resetVariables();
                          }
                          setState(() {
                            print(val);

                            _inwardType = val;
                          });
                        },
                      ),
                      _heightGap(),
                      _inwardType == 'Proposal'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownWidget(
                                  label: 'Proposal Type',
                                  items: proposalType,
                                  hintText: "Please select your Proposal Type",
                                  value: selectedProposal,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedProposal = val;
                                    });
                                  },
                                ),
                                _heightGap(),
                                selectedProposal == 'Renewal'
                                    ? Column(
                                        children: [
                                          CustomInputField(
                                            title: "Previous Policy Number",
                                            hintText:
                                                "Please enter Previous Policy Number",
                                            controller:
                                                previousPolicyController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please Enter Previous Policy Number';
                                              }
                                              return null;
                                            },
                                          ),
                                          _heightGap(),
                                        ],
                                      )
                                    : Container()
                              ],
                            )
                          : Container(),
                      _inwardType == 'Proposal' ||
                              _inwardType == 'Miscellaneous'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownWidget(
                                  items: productList,
                                  hintText: "Please select your product",
                                  value: selectedProduct,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedProduct = val;
                                    });
                                  },
                                ),
                                _heightGap(),
                              ],
                            )
                          : Container(),
                      const Text(
                        'Mode of Submission:',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(13, 154, 189, 1),
                        ),
                      ),
                      _heightGap(),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor:
                                    const Color.fromRGBO(13, 154, 189, 1),
                                value: 'Physical',
                                groupValue: _modeOfSubmission1,
                                onChanged: (value) {
                                  setState(() {
                                    _modeOfSubmission1 = value!;
                                  });
                                },
                              ),
                              const Text('Physical'),
                              const SizedBox(width: 20),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor:
                                    const Color.fromRGBO(13, 154, 189, 1),
                                value: 'Digital',
                                groupValue: _modeOfSubmission1,
                                onChanged: (value) {
                                  setState(() {
                                    _modeOfSubmission1 = value!;
                                  });
                                },
                              ),
                              const Text('Digital'),
                            ],
                          ),
                        ],
                      ),
                    ]),
                    _heightGap(),
                    CommonFunction.agreementBlock(context, (value) {
                      setState(() {
                        selectedCode = value;
                      });
                    }, (value) {
                      setState(() {
                        selectedBranch = value;
                      });
                    }, (val) {
                      setState(() {
                        selectedSBIGBranch = val;
                      });
                    }, selectedCode, selectedBranch, selectedSBIGBranch,
                        agreementCodeController),
                    _heightGap(),
                    _inwardType == 'Endorsement'
                        ? CustomInputContainer(children: [
                            InsuranceForm(getDetails: getEndorsementValues),
                            // selectedProduct == 'Advances Loss Of Profit' ||
                            //         selectedProduct ==
                            //             'Agriculture Pumpset Insurance' ||
                            //         selectedProduct == 'All Risk Insurance' ||
                            //         selectedProduct == 'Arogya Combo'
                            //     ? Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           CustomInputField(
                            //             title: 'Policy Number',
                            //             hintText: 'Please enter Policy Number',
                            //             controller: policyNumberController,
                            //           ),
                            //           CustomInputField(
                            //             title: 'Quote Number',
                            //             hintText: 'Please enter Quote Number',
                            //             controller: quoteNumberController,
                            //           ),
                            //         ],
                            //       )
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomInputField(
                                  title: 'Sales Email ID',
                                  hintText: 'Please enter Sales Email ID',
                                  controller: salesEmailController,
                                ),
                                _heightGap(),
                                CustomInputField(
                                  title: 'Sales Mobile Number',
                                  hintText: 'Please enter Sales Mobile Number',
                                  controller: salesMobileController,
                                )
                              ],
                            )
                          ])
                        : Container(),
                    _heightGap(),
                    CustomInputContainer(
                      children: [
                        _heightGap(),
                        CustomInputField(
                          title: "Customer Name",
                          hintText: "Please enter customer name",
                          controller: customerNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Customer Name';
                            }
                            return null;
                          },
                        ),
                        _heightGap(),
                        CustomRadioButton(
                            text: "Co-Insurance",
                            options: const ['Yes', 'No'],
                            groupValue: _coInsurance,
                            onChanged: (dat) {
                              setState(() {
                                _coInsurance = dat;
                              });
                            }),
                        _coInsurance == 'Yes'
                            ? CustomRadioButton(
                                text: 'Lead Type',
                                options: const ['Leader', 'Follower'],
                                groupValue: leadType,
                                onChanged: (dat) {
                                  setState(() {
                                    leadType = dat;
                                  });
                                })
                            : Container(),
                        selectedProduct == 'Advances Loss Of Profit' ||
                                selectedProduct ==
                                    'Agriculture Pumpset Insurance' ||
                                selectedProduct == 'All Risk Insurance' ||
                                selectedProduct == 'Arogya Combo'
                            ? CustomRadioButton(
                                text: "PPHC",
                                options: ['Yes', 'No'],
                                groupValue: _PPHC,
                                onChanged: (dat) {
                                  setState(() {
                                    _PPHC = dat;
                                  });
                                })
                            : Container(),
                        _heightGap(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: const Text(
                                'Customer Type:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(13, 154, 189, 1),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          const Color.fromRGBO(13, 154, 189, 1),
                                      value: 'Individual',
                                      groupValue: customerType,
                                      onChanged: (value) {
                                        setState(() {
                                          customerType = value!;
                                        });
                                      },
                                    ),
                                    const Text('Individual'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      activeColor:
                                          const Color.fromRGBO(13, 154, 189, 1),
                                      value: 'Other than Individual',
                                      groupValue: customerType,
                                      onChanged: (value) {
                                        setState(() {
                                          customerType = value!;
                                        });
                                      },
                                    ),
                                    const Text('Other than Individual'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        _heightGap(),
                        CustomInputField(
                          title: "Premium Amount",
                          hintText: "Please enter premium amount",
                          controller: premiumAmountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter the Premium Amount';
                            } else if (int.parse(value) == 0) {
                              return 'Premium amount cannot be zero';
                            }
                            return null;
                          },
                        ),
                        _heightGap(),
                      ],
                    ),
                    _heightGap(),
                    CustomInputContainer(
                      children: [
                        const Text(
                          "Instrument Details:",
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(13, 154, 189, 1),
                          ),
                        ),
                        _heightGap(),
                        DropdownWidget(
                            label: 'Instrument Type',
                            items: list,
                            hintText: "Select your instrument type",
                            value: selectedInstrumentType,
                            onChanged: (val) {
                              setState(() {
                                selectedInstrumentType = val;
                              });
                            }),
                        _heightGap(),
                        CustomInputField(
                          title: 'Instrument Number',
                          hintText: "Enter Instrument Number",
                          controller: instrumentNumberController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter the Instrument Number';
                            } else if (int.parse(value) == 0) {
                              return 'Instrument Number cannot be zero';
                            }
                            return null;
                          },
                        ),
                        _heightGap(),
                        CustomInputField(
                          title: 'Instrument Amount',
                          hintText: "Enter Instrument Amount",
                          controller: instrumentAmountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter the Instrument Amount';
                            } else if (int.parse(value) == 0) {
                              return 'Instrument amount cannot be zero';
                            }
                            return null;
                          },
                        ),
                        _heightGap(),
                        DatePickerFormField(
                          labelText: 'Select Date',
                          onChanged: (DateTime? value) {
                            setState(() {
                              instrumentDate = DateFormat('yyyy-MM-dd')
                                  .format(value as DateTime);
                            });
                            print(instrumentDate);
                            print('Selected date: $value');
                          },
                          date: instrumentDate,
                        ),
                        _heightGap(),
                        // Stack(
                        //   children: [
                        //     ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor:
                        //             const Color.fromRGBO(13, 154, 189, 1),
                        //         elevation: 10, // Elevation
                        //         shadowColor:
                        //             const Color.fromRGBO(15, 5, 158, 0.3),
                        //       ),
                        //       onPressed: () {},
                        //       child: const SizedBox(
                        //         width: double.infinity,
                        //         child: Align(
                        //           alignment: Alignment.centerLeft,
                        //           child: Padding(
                        //             padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                        //             child: Text(
                        //               'Add More Instrument Type',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Positioned(
                        //       right: 5,
                        //       bottom: 0,
                        //       top: 0,
                        //       child: Material(
                        //         color: Colors.white,
                        //         shape: const CircleBorder(),
                        //         child: IconButton(
                        //           onPressed: () {},
                        //           icon: const Icon(
                        //             Icons.add,
                        //             color: Colors.black,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 18.0),
                      ],
                    ),
                    _heightGap(),
                    CustomInputContainer(children: [
                      DatePickerFormField(
                        labelText: 'Proposer Signed Date',
                        onChanged: (DateTime? value) {
                          setState(() {
                            proposedDate = DateFormat('yyyy-MM-dd')
                                .format(value as DateTime);
                          });
                          print('Selected date: $value');
                        },
                        date: proposedDate,
                      ),
                    ]),
                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(85, 210, 241, 1),
                    Color.fromRGBO(19, 141, 172, 1),
                    // Color.fromRGBO(15, 5, 158, 1),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      // print(endorsementData);
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _heightGap() {
    return const SizedBox(
      height: 12,
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator? validator;

  const CustomInputField(
      {super.key,
      this.title,
      this.hintText,
      this.controller,
      this.inputFormatters,
      this.validator});

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
              color: Color.fromRGBO(13, 154, 189, 1), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return const Color.fromRGBO(13, 154, 189, 1);
          }
          return Colors.grey;
        }),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
        labelStyle: TextStyle(
            color: focusNode1.hasFocus
                ? const Color.fromRGBO(13, 154, 189, 1)
                : Colors.grey),
        hintText: hintText,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
    );
  }
}
