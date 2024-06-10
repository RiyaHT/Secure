import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_app/DropdownWidget.dart';
import 'package:secure_app/customInputContainer%201.dart';
// import 'package:secure_app/inwardForm%201.dart';

class CommonFunction {
  static Widget heightGap() {
    return const SizedBox(
      height: 12,
    );
  }

  static Widget firstName(BuildContext context, controller) {
    return CustomInputField(
      title: 'First Name',
      hintText: 'Enter First Name',
      controller: controller,
      keyboard: TextInputType.name,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow('[A-Za-z]')
      ],
    );
  }

  static Widget middleName(BuildContext context, controller) {
    return CustomInputField(
      title: 'Middle Name',
      hintText: 'Enter Middle Name',
      controller: controller,
      keyboard: TextInputType.name,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow('[A-Za-z]')
      ],
    );
  }

  static Widget lastName(BuildContext context, controller) {
    return CustomInputField(
      title: 'Last Name',
      hintText: 'Enter Last Name',
      controller: controller,
      keyboard: TextInputType.name,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow('[A-Za-z]')
      ],
    );
  }

  static Widget customRadio(
      BuildContext context, String label, String mode, onChanged) {
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

  static Widget agreementBlock(BuildContext context, onChanged1, onChanged2,
      onChanged3, value1, value2, value3, controller) {
    final List<String> items = [
      '23456',
      '12345',
      '34567',
    ];
    List<String> branches = <String>['Udaipur', 'Jaipur', 'Mumbai', 'Assam'];
    // final TextEditingController agreementCodeController =
    //     TextEditingController();
    return CustomInputContainer(children: [
      heightGap(),
      const Text(
        'Agreement Code:',
        style: TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(13, 154, 189, 1),
        ),
      ),
      heightGap(),
      Container(
        width: double.infinity,
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Text(
            'Select Agreement Code',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: value1,
          onChanged: onChanged1,
          buttonStyleData: const ButtonStyleData(
            // padding: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            // width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: controller,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Search Agreement Code',
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(13, 154, 189, 1),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(10, 111, 136, 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(13, 154, 189, 1), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an agreement code...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(13, 154, 189, 1),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().contains(searchValue);
            },
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              controller.clear();
            }
          },
        ),
      ),
      heightGap(),
      value1 == null
          ? const Text(
              '  Please Select Agreement Code',
              style: TextStyle(
                  color: Color.fromARGB(255, 161, 43, 35), fontSize: 12),
            )
          : Container(),
      // DropdownWidget(
      //   items: spCodes,
      //   hintText: "Please Select your SP Code",
      //   value: selectedSPCode,
      //   onChanged: (val) {
      //     selectedSPCode = val;
      //   },
      // ),
      heightGap(),
      DropdownWidget(
        label: 'Branch',
        items: branches,
        hintText: "Please Select your branch",
        value: value2,
        onChanged: onChanged2,
      ),
      heightGap(),
      DropdownWidget(
          label: 'SBIGI Branch',
          items: branches,
          hintText: "Please Select your SBIG branch",
          value: value3,
          onChanged: onChanged3),
      heightGap(),
    ]);
  }
}

class CustomInputField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator? validator;
  final keyboard;

  const CustomInputField(
      {super.key,
      this.title,
      this.hintText,
      this.controller,
      this.inputFormatters,
      this.validator,
      this.keyboard});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode1 = FocusNode();
    return TextFormField(
      // scrollPadding: EdgeInsets.all(5),
      controller: controller,
      keyboardType: keyboard,
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
