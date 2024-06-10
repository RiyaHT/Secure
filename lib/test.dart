import 'package:flutter/material.dart';

class DynamicForm extends StatelessWidget {
  final Map<String, Map<String, List<String>>> endorsementData;

  DynamicForm({required this.endorsementData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: endorsementData.entries.map((entry) {
              String endorsementType = entry.key;
              Map<String, List<String>> subtypes = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    endorsementType,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...subtypes.entries.map((subtypeEntry) {
                    String subtype = subtypeEntry.key;
                    List<String> fields = subtypeEntry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          subtype,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ...fields.map((field) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: field,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
