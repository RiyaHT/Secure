import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:secure_app/commonFunction.dart';
import 'package:secure_app/endorsementType.dart';

class InsuranceForm extends StatefulWidget {
  final Function getDetails;

  const InsuranceForm({super.key, required this.getDetails});
  @override
  _InsuranceFormState createState() => _InsuranceFormState();
}

class _InsuranceFormState extends State<InsuranceForm> {
  String? selectedProduct;
  String? selectedEndorsement;
  String? selectedSubType;
  Map newValue = {};

  Map endorsementDetails() {
    return <String, dynamic>{
      "product": selectedProduct,
      "endorsement_type": selectedEndorsement,
      "sub_type": selectedSubType,
      "newValue": newValue.toString()
    };
  }

  void initState() {
    super.initState();
  }

  void _initializeNewValue() {
    if (selectedProduct != null &&
        selectedEndorsement != null &&
        selectedSubType != null) {
      newValue.clear();
      var subTypeList = endorsementData[selectedProduct]?.firstWhere(
              (element) => element['Endorsement Type'] == selectedEndorsement)[
          'SubTypes']?[selectedSubType];
      if (subTypeList != null) {
        for (var dat in subTypeList) {
          newValue[dat['Field Name']] = '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeNewValue();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField2<String>(
          hint: const Text(
            'Select Product',
            style: TextStyle(fontSize: 12),
          ),
          isExpanded: true,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
            iconEnabledColor: Color.fromRGBO(13, 154, 189, 1),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          decoration: InputDecoration(
            labelText: 'Select Product',
            labelStyle: const TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(13, 154, 189, 1),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            focusColor: const Color.fromRGBO(13, 154, 189, 1),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                borderRadius: BorderRadius.circular(10)),
          ),
          value: selectedProduct,
          items: endorsementData.keys.map((product) {
            return DropdownMenuItem(
              value: product,
              child: Text(
                product,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedProduct = value;
              selectedEndorsement = null;
              selectedSubType = null;
              widget.getDetails(endorsementDetails());
            });
          },
        ),
        // CommonFunction.heightGap(),
        CommonFunction.heightGap(),
        if (selectedProduct != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField2<String>(
                hint: const Text(
                  'Select Endorsement Type',
                  style: TextStyle(fontSize: 12),
                ),
                decoration: InputDecoration(
                  labelText: 'Select Endorsement Type',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(13, 154, 189, 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  focusColor: const Color.fromRGBO(13, 154, 189, 1),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                  iconEnabledColor: Color.fromRGBO(13, 154, 189, 1),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                value: selectedEndorsement,
                items: endorsementData[selectedProduct]!.map((endorsement) {
                  return DropdownMenuItem(
                    value: endorsement['Endorsement Type'].toString(),
                    child: Text(
                      endorsement['Endorsement Type'],
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEndorsement = value;
                    selectedSubType = null;
                    widget.getDetails(endorsementDetails());
                  });
                },
              ),
              CommonFunction.heightGap(),
            ],
          ),
        if (selectedEndorsement != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CommonFunction.heightGap(),
              DropdownButtonFormField2<String>(
                hint: const Text(
                  'Select SubType',
                  style: TextStyle(fontSize: 12),
                ),
                decoration: InputDecoration(
                  labelText: 'Select SubType',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(13, 154, 189, 1),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  focusColor: const Color.fromRGBO(13, 154, 189, 1),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                ),
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                  iconEnabledColor: Color.fromRGBO(13, 154, 189, 1),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                value: selectedSubType,
                items: (endorsementData[selectedProduct]! as List)
                    .firstWhere((dynamic endorsement) =>
                        endorsement['Endorsement Type'] ==
                        selectedEndorsement)['SubTypes']
                    .keys
                    .map<DropdownMenuItem<String>>((String subType) {
                  return DropdownMenuItem<String>(
                    value: subType,
                    child: Text(
                      subType,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSubType = value;
                    widget.getDetails(endorsementDetails());
                  });
                },
              ),
              CommonFunction.heightGap(),
            ],
          ),
        // CommonFunction.heightGap(),
        // CommonFunction.heightGap(),
        if (selectedSubType != null)
          ...endorsementData[selectedProduct]!
              .where((element) =>
                  element['Endorsement Type'] == selectedEndorsement)
              .first['SubTypes']![selectedSubType]!
              .map<Widget>((field) {
            if (field["Type"] == "Text") {
              return Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        newValue[field["Field Name"]] = value;
                        widget.getDetails(endorsementDetails());
                      });
                    },
                    decoration: InputDecoration(
                      labelText: field["Field Name"],
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused)) {
                          return const Color.fromRGBO(13, 154, 189, 1);
                        }
                        return Colors.grey;
                      }),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  // CommonFunction.heightGap(),
                  CommonFunction.heightGap(),
                ],
              );
            } else if (field["Type"] == "Date") {
              return TextFormField(
                onChanged: (value) {
                  setState(() {
                    newValue[field["Field Name"]] = value;
                    widget.getDetails(endorsementDetails());
                  });
                },
                decoration: InputDecoration(
                  labelText: field["Field Name"],
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black12, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return const Color.fromRGBO(13, 154, 189, 1);
                    }
                    return Colors.grey;
                  }),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                },
              );
            }
            return Container();
          }).toList(),
      ],
    );
  }
}
