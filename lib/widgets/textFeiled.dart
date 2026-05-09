import 'package:flutter/material.dart';

class textfeiled extends StatelessWidget {
  textfeiled({this.onchange, this.hinttext});
  String? hinttext;
  Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (date) {
        if (date!.isEmpty) {
          return 'filed is required';
        }
      },
      onChanged: onchange,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
